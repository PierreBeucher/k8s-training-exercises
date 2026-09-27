{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # Terraform is licensed under BUSL since v1.6
          config.allowUnfree = true;
        };
      in {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              kind
              kubernetes-helm
              terraform
              kubectl
              scaleway-cli
              jq
              gh
            ];

            shellHook = ''
              echo "Run kind create cluster && kind export kubeconfig to use local Kubernetes cluster"
            '';
          };
        };
      }
    );
}
