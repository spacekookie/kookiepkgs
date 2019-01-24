/* The top-level package collection of kookiepkgs.
 * Unlike the real `top-level.nix` it's simply
 * sorted alphabetically
 */

{ system ? builtins.currentSystem }:                                                   
                                                                                   
let                                                                                    
   pkgs = import <nixpkgs> { inherit system; };                                         
                                                          
   callPackage = pkgs.lib.callPackageWith (pkgs // self);                               

   self = {                                                                             
      spacekookie-de = callPackage ./pkgs/spacekookie-de { };                                            
   };                                                                                   
   in self 

# { lib, config, pkgs ? import <nixpkgs> {} }:
# 
# rec {
#   inherit lib config pkgs;
# 
#   spacekookie-de = callPackage pkgs/spacekookie-de { };
# }
