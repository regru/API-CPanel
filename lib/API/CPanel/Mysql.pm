package API::CPanel::Mysql;

use strict;
use warnings;

use API::CPanel;
use Data::Dumper;

our $VERSION = 0.07;

# ��������� ������������ � ���� mysql
# IN:
#   - do_as_user - cPanel ������������ ��� �������� ��������� mysql-������������
#   - username   - ��� mysql-������������ ��� �������� 
#                  (���������� ����� ������ mysql-������������ � ������: <do_as_user>_<username>).
#   - password   - ������ ��� mysql-������������.
sub adduser {
    my $params = shift;

    # ������ Mysql cPanel'� � ������� �������� ��������� � ������ ������ api
    $params->{'cpanel_xmlapi_apiversion'} = 1;
    # ��������� ������ ������������ � ���� �� ����� ������������ ������������� � ��������� do_as_user
    # ���������� ��� ������ ��� ������� � cPanel �� ��������� �� ������� mysql 
    # ����� ��� cPanel-������������ � ������� do_as_user
    $params->{'user'} = delete $params->{'do_as_user'};

    $params->{'cpanel_xmlapi_module'} = 'Mysql';
    $params->{'cpanel_xmlapi_func'}   = 'adduser';

    $params->{'arg-0'}  = delete $params->{'username'};
    $params->{'arg-1'}  = delete $params->{'password'};

    return unless $params->{'user'}  &&
                  $params->{'arg-0'} &&
                  $params->{'arg-1'};

    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
            user 
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            arg-0
            arg-1',
    );

    return $result->{event}->{result};
}

# ��������� ���� mysql
# IN:
#   - do_as_user - cPanel ������������ ��� �������� ��������� mysql-����
#   - dbname     - ��� �� ��� �������� 
#                  (���������� ����� ������� �� � ������: <do_as_user>_<dbname>).
sub adddb {
    my $params = shift;

    # ������ Mysql cPanel'� � ������� �������� ��������� � ������ ������ api
    $params->{'cpanel_xmlapi_apiversion'} = 1;
    # ��������� �� �� ����� ������������ ������������� � ��������� do_as_user
    # ���������� ��� ������ ��� ������� � cPanel �� ��������� �� ������� ��
    # ��� cPanel-������������ � ������� do_as_user
    $params->{'user'} = delete $params->{'do_as_user'};

    $params->{'cpanel_xmlapi_module'} = 'Mysql';
    $params->{'cpanel_xmlapi_func'}   = 'adddb';

    $params->{'arg-0'}  = delete $params->{'dbname'};

    return unless $params->{'user'} &&
                  $params->{'arg-0'};


    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
            user 
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            arg-0',
    );

    return $result->{event}->{result};
}

# ������������� ���������� � ����
# IN:
#   - do_as_user - cPanel ������������ ��� �������� ��������� mysql-����
#   - dbname     - ��� ��
#   - dbuser     - ��� ������������
#   - perms_list - ������ ����������:
#                       alter      => ALTER
#                       temporary  => CREATE TEMPORARY TABLES
#                       routine    => CREATE ROUTINE
#                       create     => CREATE
#                       delete     => DELETE
#                       drop       => DROP
#                       select     => SELECT
#                       insert     => INSERT
#                       update     => UPDATE
#                       references => REFERENCES
#                       index      => INDEX
#                       lock       => LOCK TABLES
#                       all        => ALL
sub grant_perms {
    my $params = shift;

    # ������ Mysql cPanel'� � ������� �������� ��������� � ������ ������ api
    $params->{'cpanel_xmlapi_apiversion'} = 1;
    # ��������� �� �� ����� ������������ ������������� � ��������� do_as_user
    # ���������� ��� ������ ��� ������� � cPanel �� ��������� �� ������� ��
    # ��� cPanel-������������ � ������� do_as_user
    $params->{'user'} = delete $params->{'do_as_user'};

    $params->{'cpanel_xmlapi_module'} = 'Mysql';
    $params->{'cpanel_xmlapi_func'}   = 'adduserdb';

    $params->{'arg-0'}  = delete $params->{'dbname'};
    $params->{'arg-1'}  = delete $params->{'dbuser'};
    $params->{'arg-2'}  = delete $params->{'perms_list'};

    return unless $params->{'user'}  &&
                  $params->{'arg-0'} &&
                  $params->{'arg-1'} &&
                  $params->{'arg-2'};

    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
            user 
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            arg-0
            arg-1
            arg-2',
    );

    return $result->{event}->{result};
}




1;
