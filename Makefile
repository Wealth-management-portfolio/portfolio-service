docker build:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 088066169621.dkr.ecr.us-east-1.amazonaws.com
	docker build -t 088066169621.dkr.ecr.us-east-1.amazonaws.com/portfolio-service:latest .
	docker push 088066169621.dkr.ecr.us-east-1.amazonaws.com/portfolio-service:latest