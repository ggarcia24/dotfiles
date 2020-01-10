#! /usr/bin/env python
"""
Gonzalo's Helper Application
"""

__author__ = "Gonzalo Garcia <gonzalogarcia243@gmail.com>"
__version__ = "0.1.0"

from string import Template

import click
import pathlib2 as pathlib
from python_hosts import Hosts, HostsEntry


try:
    import colorama
    colorama.init()
except ImportError:
    colorama = None

try:
    from termcolor import colored
except ImportError:
    colored = None


class Roberto(click.MultiCommand):
    """
    Class to implement sub commands
    """
    def list_commands(self, ctx):
        return [
            'site'
        ]

    def get_command(self, ctx, name):
        return site


@click.group()
@click.pass_context
def site(ctx):
    """
    Interact with sites on the homebrew apache
    """
    pass


@site.command()
@click.option('--with-ssl', is_flag=True, default=False, help='Enable SSL for the site')
@click.argument('project', type=click.Path(exists=True))
@click.argument('name')
@click.argument('php_ver')
@click.pass_context
def create(ctx, with_ssl, project, name, php_ver):
    """
    Create a site in homebrew apache
    """
    debug = ctx.obj['DEBUG']
    fpm_ports = {
        '5.6': 9056,
        '7.0': 9070,
        '7.1': 9071,
        '7.2': 9072
    }
    apache_config = '''<VirtualHost *:80>
    ServerAdmin webmaster@${project_name}.local
    DocumentRoot "${project_path}/public_html"
    ServerName ${project_name}.devel
    ErrorLog "/usr/local/var/log/httpd/${project_name}-error_log"
    CustomLog "/usr/local/var/log/httpd/${project_name}-access_log" common
    <FilesMatch \\.php$$>
      SetHandler proxy:fcgi://localhost:${php_fpm_port}
    </FilesMatch>
</VirtualHost>
'''
    if with_ssl:
        apache_config += '''
<VirtualHost *:443>
    ServerAdmin webmaster@${project_name}.local
    DocumentRoot "${project_path}/public_html"
    ServerName ${project_name}.devel
    ErrorLog "/usr/local/var/log/httpd/${project_name}-error_log"
    CustomLog "/usr/local/var/log/httpd/${project_name}-access_log" common
    SSLEngine on
    SSLCertificateFile "/usr/local/etc/httpd/server.crt"
    SSLCertificateKeyFile "/usr/local/etc/httpd/server.key"

    #SSLOptions +FakeBasicAuth +ExportCertData +StrictRequire
    <FilesMatch \\.php$$>
      SetHandler proxy:fcgi://localhost:${php_fpm_port}
    </FilesMatch>
    <FilesMatch "\\.(cgi|shtml|phtml|php)$$">
        SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory "/usr/local/var/www/cgi-bin">
        SSLOptions +StdEnvVars
    </Directory>

    BrowserMatch "MSIE [2-5]" \\
             nokeepalive ssl-unclean-shutdown \\
             downgrade-1.0 force-response-1.0

    CustomLog "/usr/local/var/log/httpd/${project_name}-ssl_request_log" \\
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \\"%r\\" %b"

</VirtualHost>
'''
    parsed_template = Template(apache_config).substitute({
        'project_name': name,
        'project_path': project,
        'php_fpm_port': fpm_ports[php_ver]
    })

    http_sites_path = '/usr/local/etc/httpd/sites'
    if not debug:
        pathlib.Path(http_sites_path).mkdir(parents=True, exist_ok=True)
    else:
        click.echo("Checking if directory '%s' exists" % http_sites_path)

    apache_config_filename = http_sites_path + '/' + name + '.local.conf'
    if not debug:
        with open(apache_config_filename, 'w') as apache_config_file:
            apache_config_file.write(parsed_template)
    else:
        click.echo("I should now create a file named '%s'" % apache_config_filename)
        click.echo("That has the following content: ")
        click.echo(parsed_template)




# We need to declare a default context settings
CONTEXT_SETTINGS = {}


def print_version(ctx, param, value):
    if not value or ctx.resilient_parsing:
        return
    click.echo('Version ' + __version__)
    ctx.exit()


@click.command(cls=Roberto, context_settings=CONTEXT_SETTINGS)
@click.option('-v', '--verbose', is_flag=True, help='Enables verbose mode.')
@click.option('-d', '--debug/--no-debug', is_flag=True, default=False)
@click.option('-V', '--version', is_flag=True, callback=print_version, expose_value=False, is_eager=True)
@click.pass_context
def main(ctx, verbose, debug):
    """A complex command line interface."""
    if ctx.obj is None:
        ctx.obj = {}
    ctx.obj['VERBOSE'] = verbose
    ctx.obj['DEBUG'] = debug


# Main entry point
if __name__ == '__main__':
    main()
