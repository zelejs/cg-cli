#!/usr/bin/env perl
use lib qw(local);
use YAML::Tiny;
use Data::Dumper;

my $cmd = shift @ARGV;
my $param = shift @ARGV;
my $cmd2 = "$cmd$param";

sub println{
   my ($line) = @_;
   print "$line\n";
}

my $DEFAULT_COMPOSE = "cg-compose.yaml";
my $DEFAULT_COMPOSE_PATH = "./cg-compose.yaml";

sub usage {
    println "Usage:";
    println "   cg-compose [-f <arg>...] [options] [COMMAND] [ARGS...]";
    println "   cg-compose -h|--help";
    println "";
    println 'Options:';
    #println '  -f, --file FILE             Specify an alternate compose file (default: cg-compose.yml)';
    println '   --gen                       generate option for cg-cli --gen';

    println "";
    println 'Commands:';
    println '  init               Run sql(src/main/resources/sql/*-schema.sql) and gen or update persistence.';
    println '  build              Build API src base on the generated *-schema.sql file and cruds.xml';

    #echo '  bundle             Generate a Docker bundle from the Compose file'

    exit(0);
}

if ( ! $cmd ){
   usage;
}

#if (! (-f $DEFAULT_COMPOSE) ){
#   println "$DEFAULT_COMPOSE not exist !";
#   exit(0);
#}

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
my $compose_file="./$DEFAULT_COMPOSE";
if ( ! (-f $compose_file) ){
   print `cp $dir/assets/$DEFAULT_COMPOSE $compose_file`;
}

if ( $cmd =~ /^init$/ ){
   $cmd = cmdinittable;

}elsif($cmd =~ /build/ ){
   $cmd = cmdbuildapp;
}else{
    usage;
}

sub inittable {
   #println 'Start to init tables ...';

   my $yaml_file = $DEFAULT_COMPOSE_PATH;
   my @yaml_lines = &read_lines($yaml_file);

   ## remove comment lines and comments after line
    my @lines=();
    foreach(@yaml_lines){
        if(/^#/){
            next;
        }
        s/#.+//;
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

   ## run sql
   print `cg-cli db run sql`;
   #print `cg-cli db show tables`;

   ## init tables
   my @target_tables = @{$yaml->[0]->{tables}};
   my $tables_line = "cg-cli crud init table ";
   foreach(@target_tables){
      $tables_line = "$tables_line $_";
   }

   #println $tables_line;
   print `$tables_line $param`;
}

sub buildapp{
   println "Start build app...";
}


## main
if ( $cmd =~ cmdinittable ){
   &inittable;

}elsif ( $cmd =~ cmdbuildapp ){
   &buildapp;

}else{
    println "Unknown cmd: $cmd\n";
}


sub read_lines{
  my ($in) = @_;

  my @data;

  open my $fh, "<", "$in";
  @data = <$fh>;
  close $fh;

  return @data;
}
