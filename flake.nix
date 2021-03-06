{
  description = ''A MessagePack binding for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."msgpack-master".dir   = "master";
  inputs."msgpack-master".owner = "nim-nix-pkgs";
  inputs."msgpack-master".ref   = "master";
  inputs."msgpack-master".repo  = "msgpack";
  inputs."msgpack-master".type  = "github";
  inputs."msgpack-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."msgpack-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}