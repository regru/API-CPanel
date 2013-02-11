package API::CPanel::Domain;

use strict;
use warnings;

use API::CPanel;
use Data::Dumper;

our $VERSION = 0.09;

# Возвращает список доменов
sub list {
    my $params = shift;

    return API::CPanel::action_abstract(
        params       => $params,
        func         => 'listaccts',
        container    => 'acct',
        result_field => 'domain',
        want_hash    => '1',
    );
}


# Изменяет основной ип сайта
sub change_site_ip {
    my $params = shift;

    return API::CPanel::action_abstract(
        params         => $params,
        func           => 'setsiteip',
        container      => 'result',
        allowed_fields => 'ip user domain',
    );
}

# Удалить дополнительный домен
# IN:
#   - domain - The domain name of the addon domain you wish to delete. (e.g. sub.example.com).
# http://docs.cpanel.net/twiki/bin/view/ApiDocs/Api2/ApiAddonDomain
sub del_addon_domain {
    my $params = shift;

    $params->{'cpanel_xmlapi_apiversion'} = 2;
    $params->{'user'} = delete $params->{'do_as_user'};

    $params->{'cpanel_xmlapi_module'} = 'AddonDomain';
    $params->{'cpanel_xmlapi_func'}   = 'deladdondomain';

    return unless $params->{'user'}      &&
                  $params->{'domain'};

    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
            user 
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            domain
            pass
            subdomain',
    );

    return $result;
}

# Добавить дополнительный домен
# IN:
#   - dir       - The path that will serve as the addon domain's home directory.
#   - newdomain - The domain name of the addon domain you wish to create. (e.g. sub.example.com).
#   - pass      - Password to access and edit the addon domain's files.
#   - subdomain - This value is the subdomain and FTP username corresponding to the new addon domain.
# http://docs.cpanel.net/twiki/bin/view/ApiDocs/Api2/ApiAddonDomain
sub add_addon_domain {
    my $params = shift;

    $params->{'cpanel_xmlapi_apiversion'} = 2;
    $params->{'user'} = delete $params->{'do_as_user'};

    $params->{'cpanel_xmlapi_module'} = 'AddonDomain';
    $params->{'cpanel_xmlapi_func'}   = 'addaddondomain';

    return unless $params->{'user'}      &&
                  $params->{'dir'}       &&
                  $params->{'newdomain'} &&
                  $params->{'pass'}      &&
                  $params->{'subdomain'};

    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
            user 
            cpanel_xmlapi_module 
            cpanel_xmlapi_func 
            cpanel_xmlapi_apiversion 
            dir
            newdomain
            pass
            subdomain',
    );

    return $result;
}

# Р’РѕР·РІСЂР°С‰Р°РµС‚ СЃРїРёСЃРѕРє РґРѕРїРѕР»РЅРёС‚РµР»СЊРЅС‹С… РґРѕРјРµРЅРѕРІ

sub list_addon_domain {
    my $params = shift;
    
    $params->{'cpanel_xmlapi_apiversion'} = 2;
    $params->{'user'} = delete $params->{'do_as_user'};
            
    $params->{'cpanel_xmlapi_module'} = 'AddonDomain';
    $params->{'cpanel_xmlapi_func'}   = 'listaddondomains';
                    
    my $result = API::CPanel::action_abstract(
        params         => $params,
        func           => 'cpanel',
        want_hash      => '1',
        allowed_fields => '
                user
            cpanel_xmlapi_module
            cpanel_xmlapi_func
            cpanel_xmlapi_apiversion'
    );
                                                                                                            
    return $result;
}
                                                                                                                
1;
