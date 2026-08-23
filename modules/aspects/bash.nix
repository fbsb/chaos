{
  chaotic.bash = {
    homeManager = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        enableVteIntegration = true;
        historyControl = [ "ignoreboth" ];
      };
    };
  };
}
