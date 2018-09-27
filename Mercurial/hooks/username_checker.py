#!/usr/bin/env python

def transaction_handler(ui, repo, hooktype, node=None, source=None, **kwargs):
    status = False
    if hooktype not in ['pretxnchangegroup', 'pretxncommit']:
        ui.write('Hook should be pretxncommit/pretxnchangegroup not "%s".' % hooktype + '\n')
        return True
    
    from mercurial import scmutil
    if 'url' in kwargs:
        auth_username = kwargs['url'].split(':')[-1]
    else:
        ui.debug('Ignoring, URL is not defined...' + '\n')
        return False
    ui.debug('Username defined in auth is: %s\n' % auth_username  + '\n')

    if hooktype == 'pretxncommit':
        ctx = repo[node]
        status = not check_context(ui,ctx,auth_username)
    elif hooktype == 'pretxnchangegroup':
        from mercurial import scmutil
        for rev in scmutil.revrange(repo, ['%s::' % node]):
            ctx = repo[rev]
            status = not check_context(ui,ctx,auth_username)
    return int(status)
    
def check_context(ui, ctx, username):
    node_username = ctx.user()
    if(node_username != username):
        ui.debug('Username defined in ui is %s\n' % node_username + '\n')
        ui.warn('The username defined in the auth section is not the same as the one in the ui for commit' + '\n')
        return False
    return True