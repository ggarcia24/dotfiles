import re
import logging

#start precommit_badcomment
def precommit_badcomment(ui, repo, hooktype, node=None, **kwargs):
    logger = logging.getLogger('precommit_badcomment')
    status = False
    jiraIdRegExp = re.compile('([A-Z]{2,}-[0-9]+)');
    ignore_merge = ui.configbool('precommit_badcomment', 'ignore_merge', False)
    ui.note('Ignore merges?' + str(ignore_merge) + '\n')
    if hooktype == 'pretxncommit':
        ui.status('Checking commit for a Jira Issue Number\n')
        ctx = repo[node]
        nodeParentsCount = len(ctx.parents())
        logMessage = ctx.description()
        result = jiraIdRegExp.search(logMessage)
        if result is None:
            ui.status('You must include the JIRA issue number within your comment' + '\n')
            status = True;
    elif hooktype == 'pretxnchangegroup':
        from mercurial import scmutil
        ui.status('Checking incomming changes for a Jira Issue Number\n')
        for rev in scmutil.revrange(repo, ['%s::' % node]):
            ctx = repo[rev]
            nodeParentsCount = len(ctx.parents())
            ui.note('Checking revision: ' + str(rev) + '\n')
            logMessage = ctx.description()
            ui.note('Log message is: ' + logMessage + '\n');
            result = jiraIdRegExp.search(logMessage)
            if result is None:
                ui.status('Commit #' + str(rev) + ': You must include the JIRA issue number within your comment' + '\n')
                status = True;
    else:
        raise util.Abort(_('precommit_badcomment installed as unsupported hooktype: %s') % hooktype)
    return status
#end precommit_badcomment
