1. For building and pushing images to ecr:
    makefile is being used
    build : makes build from produciton.yaml
    push : push image to ecr and so on

2. Each app has its own directory and files required defined inside the app dir

3. For env var env.example is defined for running local stack

4. For build : job defined manual-build (makes build run on github and pushes image to ecr)

5. For Deployment: job defined staging-deploy takes input from user to which env user wants to deploy and version tag of image , then it triggers aws code deploy for deployment (going to server and updating version tag of image and restarting stack) and announcing on slack
