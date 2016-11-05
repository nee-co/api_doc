.PHOENY: image doc

image:
	docker build -t neeco-api .

doc:
	docker run --rm -v $(PWD):/tmp -t neeco-api aglio -i /tmp/neeco.apib -o /tmp/neeco.html
