{ nixvim, lib, ... }: 
let 
  nixvimConfiguration = import ./config.nix;
  recursiveMerge = with lib; attrList:
    let f = attrPath:
      zipAttrsWith (n: values:
	if tail values == []
	  then head values
	else if all isList values
	  then unique (concatLists values)
	else if all isAttrs values
	  then f (attrPath ++ [n]) values
	else last values
      );
    in f [] attrList;
in nixvim.legacyPackages."aarch64-darwin".makeNixvim 
  (
    recursiveMerge
    [
      nixvimConfiguration
      (import ./bufferline.nix)
    ]
  )
