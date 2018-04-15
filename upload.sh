rm -rf public || exit 2
~/apps/hugo/hugo.exe || exit 1

venv/Scripts/activate
pip install awscli || exit 3

echo "syncing with AWS..."
aws s3 sync public s3://www.neglostyti.com --acl public-read

echo "Done."
