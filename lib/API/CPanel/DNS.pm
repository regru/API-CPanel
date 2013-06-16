package API::CPanel::DNS;

use strict;
use warnings;

use API::CPanel;
use Data::Dumper;

our $VERSION = 0.12;

# Возвращает дамп зоны (XML API)
# params: domain
sub dumpzone {
    my $params = shift;

    return API::CPanel::action_abstract(
        params         => $params,
        func           => 'dumpzone',
        want_hash      => 1,
        container      => 'result',
        allowed_fields => "domain",
    );
}

# Возвращает дамп зоны (Cpanel API 2)
# params: user, domain
sub fetchzone {
    my $params = shift;

    $params->{'cpanel_xmlapi_apiversion'} = 2;
    $params->{'cpanel_xmlapi_module'}     = 'ZoneEdit';
    $params->{'cpanel_xmlapi_func'}       = 'fetchzone';

    return unless $params->{domain} && $params->{user};

    return API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => 1,
        container      => 'data',
        allowed_fields => '
            user
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            domain',
    );
}

# добавляет записи A, MX, CNAME, NS, PTR
sub add_record {
    my $params = shift;

    my $allowed_fields = {
        A     => 'address class',
        MX    => 'exchange preference class',
        CNAME => 'cname class',
        TXT   => 'txtdata class',
        NS    => 'nsdname class',
        PTR   => 'ptrdname class',
        SRV   => 'target port weight priority class',
    }->{$params->{type}};


    return API::CPanel::action_abstract(
        want_hash      => delete $params->{want_hash},
        params         => $params,
        func           => 'addzonerecord',
        container      => 'result',
        allowed_fields => "zone type name $allowed_fields",
    );
}

# изменяет записи A, MX, CNAME, NS, PTR
sub edit_record {
    my $params = shift;

    my $allowed_fields = {
        A     => 'address class',
        MX    => 'exchange preference class',
        CNAME => 'cname class',
        TXT   => 'txtdata class',
        NS    => 'nsdname class',
        PTR   => 'name ptrdname class',
        SRV   => 'target port weight priority class',
    }->{$params->{type}};

    return API::CPanel::action_abstract(
        want_hash      => delete $params->{want_hash},
        params         => $params,
        func           => 'editzonerecord',
        container      => 'result',
        allowed_fields => "domain Line name $allowed_fields",
    );
}


# удаляет записи A, MX, CNAME, NS, PTR
sub remove_record {
    my $params = shift;

    return API::CPanel::action_abstract(
        want_hash      => delete $params->{want_hash},
        params         => $params,
        func           => 'removezonerecord',
        container      => 'result',
        allowed_fields => "domain Line",
    );
}

1;
