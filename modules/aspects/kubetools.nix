{
  chaotic.kubetools = {
    homeManager = { pkgs, ... }: {
      programs.k9s.enable = true;
      home.packages = with pkgs; [
        kubectl
        (runCommand "kubectl-k" { } ''
          mkdir -p $out/bin
          ln -s ${lib.getExe kubectl} $out/bin/k
        '')
        kubectx
        stern
        kubelogin-oidc
        fzf
        kubernetes-helm
      ];

      home.shellAliases = {
        kubelogin = "kubectl-oidc_login";
        ktx = "kubectx";
        kns = "kubens";
      };

      programs.zsh.oh-my-zsh.plugins = [
        "kubectl"
        "k9s"
      ];
    };
  };
}
