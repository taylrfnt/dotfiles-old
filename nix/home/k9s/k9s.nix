{config, pkgs, ...}:

{
  enable = true;
  aliases = {
    aliases = {
      dp = "deployments";
      sec = "v1/secrets";
      jo =  "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies"; 
    };
  };
  skins = {
    catppuccin_mocha = ./catppuccin_mocha.yaml;
  };
  settings = {
    k9s = {
     ui = {
        skins = "catppuccin_mocha";
      };
    };
  };
}
