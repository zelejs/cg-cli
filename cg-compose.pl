#!/usr/bin/env perl
use lib qw(local);
use YAML::Tiny;
use Data::Dumper;
use File::Copy;


sub println{
   my ($line) = @_;
   print "$line\n";
}

sub usage {
    println "Usage:";
    println "   cg-compose [options] [COMMAND] [ARGS...]";
    println "   cg-compose -h|--help";
    println "";
    println 'Options:';
    println '  -f, --file FILE             Specify an alternate compose file (default: cg-compose.yml)';
    #println '  --gen                       --gen for cg-cli';

    println "";
    println 'Commands:';
    println '  init               Run sql(src/main/resources/sql/*-schema.sql) and gen or update persistence.';
    println '  build              Build API src base on the generated *-schema.sql file and cruds.xml';

    #echo '  bundle             Generate a Docker bundle from the Compose file'
}

my $DEFAULT_COMPOSE_FILE = "cg-compose.yaml";

## for -h|--help
my $HELP = $ARGV[0];
if ( ! $HELP || $HELP=~/^-h$/ || $HELP=~/^--help$/ ){
   usage;

   ## exit right now if exist cg-compose.yaml
   if(-f $DEFAULT_COMPOSE_FILE){
      exit(0);
   }
}

my @argv=();

## check option
my $COMPOSE_FILE=undef;
my $OP_COMPOSE_FILE=undef;  ## whether specific the cg-compose file
my $OP_GEN=undef;    ## whether --gen 
foreach(@ARGV){
    if(/^-f$/ || /^--file$/){
      $OP_COMPOSE_FILE=$_;
      next;
    }
    if($OP_COMPOSE_FILE && !$COMPOSE_FILE){
       $COMPOSE_FILE=$_;
       next;
    }
    if(/^--gen$/){
      $OP_GEN=$_;
      next;
    }
    push(@argv,$_);
}

if(!$COMPOSE_FILE){
   $COMPOSE_FILE="./$DEFAULT_COMPOSE_FILE";
}
#print $COMPOSE_FILE."\n";
$OP_GEN='--gen';  ## default gen directly


##########################
### main
##########################
my $cmd = shift @argv;

## main
my $os_name=`uname`;
my $dir;
if ( $os_name =~ /^Darwin$/ ){
   $dir=`greadlink -f "$0"`;
}else{
   $dir=`readlink -f "$0"`;
}

### start ###
#dir=$(readlink -f "$0")
$dir =~ s/[\r\n\s\t]+$//;
$dir =~ s/\/[\w\-\.]+$//;

## working dir
my $compose_file="$COMPOSE_FILE";
if ( ! (-f $compose_file) ){
   print `cp $dir/assets/$DEFAULT_COMPOSE_FILE $compose_file`;
}

## cp cg-compose.yaml file and check args again
if ( ! $HELP || $HELP=~/^-h$/ || $HELP=~/^--help$/ ){
   exit(0);
}


## move all .sql file to src/main/resources/sql/*-schema.sql
my $sqlsdir='./src/main/resources/sql';
my $files_ref=&read_sql_files;
my @files=@{$files_ref};
if($files>0){
   if(!(-d $sqlsdir)){
      mkdir($sqlsdir);
   }
}
foreach(@files){
   my $file=$_;
   if(/-schema\.sql/){
      print `mv $file $sqlsdir`;
   }else{
      s/\.sql/-schema.sql/;
      print `mv $file $sqlsdir/$_`;
   }
}


my $YAML = init_config($compose_file);

## pre-process cmd
if ( $cmd =~ /^init$/ ){
   $cmd = cmdinittable;

}elsif($cmd =~ /build/ ){
   $cmd = cmdbuildapp;
}else{
    print "Unkown command :".$cmd."\n";
    exit(1);
}


## main
if ( $cmd =~ cmdinittable ){
   &inittable;

}elsif ( $cmd =~ cmdbuildapp ){
   &buildapp;

}else{
    println "Unknown command: $cmd\n";
}



sub inittable {
   println 'Start to init tables ...';

   print `cg-cli db run sql`;
   #print `cg-cli db show tables`;

   ## init tables
   my $command_line = "cg-cli crud init table ";

   my @target_tables = @{$YAML->[0]->{tables}};
   foreach(@target_tables){
      $command_line = "$command_line $_";
   }

   ## default w/ --gen
   if($OP_GEN){
      push(@argv, '--gen');
   }

   #println $tables_line;
   print `$command_line @argv`;
}


sub buildapp{
   println "Start build app...";

   ## default w/ --gen
   if($OP_GEN){
      push(@argv, '--gen');
   }

   print `cg-cli crud xml @argv`;
}


sub init_config{
   my ($yaml_file) = @_;

   my @yaml_lines = &read_lines($yaml_file);

   ## remove comment lines and comments after line
    my @lines=();
    foreach(@yaml_lines){
        if(/^#/){  ## skip comment
           next;
        }
        s/#.+//;   ## remove comment tail
        push(@lines,$_);
    }

    ## end remove comments
    my $yaml_string = join("", @lines);
    #print $yaml_string;

    ## remove all comment lines for YAML
    my $yaml = YAML::Tiny->read_string( $yaml_string );
    #print Dumper($yaml);

   
   ## get and update module
   my $module = $yaml->[0]->{module};
   print `cg-cli module set $module`;
   print `cg-cli module get`;

   ## get and update connection
   #cg-cli db set url <database> [localhost] [3306] [root] [root]
   my $host = $yaml->[0]->{connection}->{host};

   my $ip = '127.0.0.1';
   my $port='3306';
   my $db ='test';
   if($host =~ /([\d\.]+):(\d+)\/(\w+)/){
      $ip = $1;
      $port=$2;
      $db = $3;
   }elsif($host =~ /([\d\.]+)\/(\w+)/){
      $ip = $1;
      $db = $2;
   }

   my $username = $yaml->[0]->{connection}->{username};
   my $password = $yaml->[0]->{connection}->{password};

   print `cg-cli db set url $db $ip $port $username $password`;
   print `cg-cli db get url`;

   return $yaml;
}

sub read_lines{
  my ($in) = @_;

  my @data;

  open my $fh, "<", "$in";
  @data = <$fh>;
  close $fh;

  return @data;
}


sub read_sql_files{
    my $workingdir="./";
    opendir(my $dh, $workingdir) || die "Can't opendir workingdir: $!";
    my @dots = grep { /\.sql/ } readdir($dh);
    #my @dots = readdir($dh);
    closedir $dh;
    return \@dots;
}
