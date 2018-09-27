import re
import logging

def precommit_badcomment(ui, repo, hooktype, node=None, **kwargs):
    logger = logging.getLogger('precommit_badcomment')
    status = False
    jiraIdRegExp = re.compile('([A-Z]{2,}-[0-9]+)');
    merge = ui.configbool('precommit_badcomment', 'merge', True)
    if hooktype == 'pretxncommit':
        ui.status('Checking commit for a Jira Issue Number\n')
        ctx = repo[node]
        logMessage = ctx.description()
        ui.note('Log message is: ' + logMessage + "\n");
        result = jiraIdRegExp.search(logMessage)
        ui.note('Is this node a merge? ' + str(len(ctx.parents()) > 1) + '\n')
        if result is None:
            if  merge == True and len(ctx.parents()) > 1:
                ui.status('You must include the JIRA issue number within your comment (AGR-XXX)' + '\n')
                status = True;
            else:
                ui.note('Ignoring node since is a merge\n');
        else:
            #status = True;
            ui.note('Jira Issue is: ' + ''.join(result.groups()) + '\n')
    elif hooktype == 'pretxnchangegroup':
        from mercurial import scmutil
        ui.status('Checking incomming changes for a Jira Issue Number\n')
        for rev in scmutil.revrange(repo, ['%s::' % node]):
            ctx = repo[rev]
            ui.note('Checking revision: ' + str(rev) + '\n')
            logMessage = ctx.description()
            ui.note('Log message is: ' + logMessage + '\n');
            result = jiraIdRegExp.search(logMessage)
            ui.note('Is this node a merge? ' + str(len(ctx.parents()) > 1) + '\n')
            if result is None:
                if  merge == True and len(ctx.parents()) > 1:
                    ui.status('Commit #' + str(rev) + ': You must include the JIRA issue number within your comment (AGR-XXX)' + '\n')
                    status = True;
                else:
                    ui.note('Ignoring node since is a merge\n');
            else:
                ui.note('Jira Issue is: ' + ''.join(result.groups()) + '\n')
                # status = True;
    else:
        raise util.Abort(_('precommit_badcomment installed as unsupported hooktype: %s') % hooktype)
    return status
#end precommit_badcomment