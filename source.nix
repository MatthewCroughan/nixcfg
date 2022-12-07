
{ fetchFromGitLab }:

rec {
  version = "13c61e59e7e71f7d7dc2cfce5f65904fb118ca21";
  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "soapbox-pub";
    repo = "rebased";
    rev = "13c61e59e7e71f7d7dc2cfce5f65904fb118ca21";
    sha256 = "00g02ndxb9fq29j1nz9nknqnrm4cqfnizlpraas7n3cxqaxqzyfj";
  };
}

