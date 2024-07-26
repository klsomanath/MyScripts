head_branch="<Branch Name>"

workflow_id="<YML File Name>"


## Please don't commit the file with github token hardcoded. Else the token will be revoked by github as it is not best practice

## If referring in an YML file use SECRETS for defining the token
token="<GitHub Token>"

owner="<User Name>" #If it is organisation it will be org/repos/reponame

repo="<Repository Name>"

api_command="curl -L -H \"Accept: application/vnd.github+json\" -H \"Authorization: Bearer $token \" -H \"X-GitHub-Api-Version: 2022-11-28\" https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs | jq -r '.workflow_runs[] | select(.head_branch == \"$head_branch\") | select(.status == \"completed\") | select(.conclusion == \"success\") | .head_sha' | head -1"

last_successful_commit=$(eval $api_command)

echo $last_successful_commit
