## Get the Work-flow file for ehich you want to get the statuses
workflow_file="example.yml"

token="<Paste your SF Org Token>"

owner="<Paste your github username>"

repo="<Paste your github repository name>"

last_successful_commit=$((curl -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $token " -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_file/runs) | jq -r '.workflow_runs[] | select(.status == "completed" ) | select(.conclusion == "success") | .head_sha' | head -1 )

echo $last_successful_commit