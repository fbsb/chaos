{
  chaotic.kubetools = {
    homeManager = { pkgs, ... }: {
      programs.k9s.enable = true;
      home.packages = with pkgs; [
        kubectl
        kubectx
        stern
        kubelogin-oidc
      ];
    };
  };
}
