{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let  
        pkgs = nixpkgs.legacyPackages.${system}; 
      in {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              kind
              kubernetes-helm
            ];

            shellHook = ''
              echo "Run kind create cluster && kind export kubeconfig to use local Kubernetes cluster"
            '';
          };
        };
      }
    );
}
