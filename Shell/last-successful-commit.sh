head_branch="<Branch Name>"

workflow_id="<YML File Name>"

token="<GitHub Token>"

owner="<User Name>"

repo="<Repository Name>"

api_command="curl -L -H \"Accept: application/vnd.github+json\" -H \"Authorization: Bearer $token \" -H \"X-GitHub-Api-Version: 2022-11-28\" https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs | jq -r '.workflow_runs[] | select(.head_branch == \"$head_branch\") | select(.status == \"completed\") | select(.conclusion == \"success\") | .head_sha' | head -1"

last_successful_commit=$(eval $api_command)

echo $last_successful_commit
