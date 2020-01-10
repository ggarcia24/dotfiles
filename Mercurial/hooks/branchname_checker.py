#!/usr/bin/env python

import re
#import logging

def transaction_handler(ui, repo, hooktype, node=None, **kwargs):
    status = False
    
    if hooktype not in ['pretxnchangegroup', 'pretxncommit', 'precommit']:
        ui.write('[check_branch] Hook should be pretxncommit/pretxnchangegroup not "%s".' % hooktype)
        return True
    
    if hooktype == 'pretxncommit':
        ctx = repo[node]
        status = not check_branch(ui,ctx)
    elif hooktype == 'pretxnchangegroup':
        from mercurial import scmutil
        for rev in scmutil.revrange(repo, ['%s::' % node]):
            ctx = repo[rev]
            return not check_branch(ui,ctx)
    return int(status)
    
    
def check_branch(ui, ctx):
    branchNameRegExp = re.compile('([A-Z]{2,}-[0-9]+[a-zA-Z-_]+)');
    ignore_merge = ui.configbool('branchname_checks', 'ignore_merge', False)
    ignore_previousbranchdate = ui.config('branchname_checks', 'ignore_previousbranchdate', False)
    ui.debug('[check_branch] Ignore merges? ' + str(ignore_merge) + '\n')
    ui.debug('[check_branch] Ignore branches created prior to a date? ' + str(bool(ignore_previousbranchdate)) + '\n')
    branch = ctx.branch()
    ui.debug('[check_branch] Branch name: %s' % branch + '\n')
    result = branchNameRegExp.search(branch)
    
    merge = len(ctx.parents()) > 1
    
    if (merge is True) and (ignore_merge is True):
        ui.debug('[check_branch] %s is a merge, ignoring' % ctx.rev() + '\n')
        return True
        
    if (branch not in ['default','development','staging']) and (result is None):
        ui.note('[check_branch] %s has a branch name does not meets naming conventions' % str(ctx.rev()) + '\n')
        return False
        
    ctx.parents()
    
    return True
