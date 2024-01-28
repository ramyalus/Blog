1. To check the git user name: 
	=> git config --global user.name "your name"
	=> git config --global user.email "your mail id"

2. credentails check:
	=> git config credential.username "github-username"

3. To initalize git:
   => git init

4. To add all files or single files
 => git add . 

5. to commit
 => git commit -m "your message"

6. add local repository to remote repo (only for newly created repos)
	=>git remote add origin https://github.com/ramyalus/Blog.git

7. push commits to branch
	=> git push -u origin main

8. To create new branch:
	=> git checkout -b " branch-name" (it will create branch and automatically checkoout to the branch.)
	=> git branch "branch-name" (it just creates branch.)