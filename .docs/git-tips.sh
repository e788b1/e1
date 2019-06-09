# Adding your SSH key to the ssh-agent
ssh-keygen -t rsa -b 4096 -C "e788b1@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

xsel -b < < ~/.ssh/id_rsa.pub

# config git
git config --global user.name "e788b1"
git config --global user.email "e788b1@gmail.com"

# init repo
mkdir repo & cd repo
git init
git remote add origin git@github.com:e788b1/repo.git

echo "# xwga" >> README.md

cat > .gitignore << "EOF"
*
!.gitignore
!README.md
!Update.sh
!
EOF

git add .
git commit -a
git push -u origin master

# remove ignored
ignored_files=`git ls-files -i --exclude-from=.gitignore`
for ignored_file in $ignored_files; do
    git rm -r --cached $ignored_file
done
