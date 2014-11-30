Docker build for ReadTheDocs (RTD)
================================

A Dockerfile-repository for an image imitating installations of [Read The Docs][0]

### Status (Dec-2014)
- Built images are uploaded to [index.docker.io][1]
- Python3 under evaluation.

### Usage:

 - Install Docker: [http://docs.docker.io/][2]
 - Execute
 `docker run -d --name ReadTheDocs -p 8000:8000 shaker/readthedocs`
 - Browse [http://&lt;your server ip address&gt;:8000/][3]
 - Stop and start again
   - `docker stop ReadTheDocs`
   - `docker start ReadTheDocs`
 - username/password for admin:
   - `username` is `admin`
   - `password` is `admin`
- Read [RTD Installation Instructions][4] for further help.

  [0]: http://readthedocs.org
  [1]: https://index.docker.io/u/ankostis/
  [2]: http://docs.docker.io/en/latest/ "docs.docker.io"
  [3]: http://127.0.0.1:8000/
  [4]: http://docs.readthedocs.org/en/latest/install.html
