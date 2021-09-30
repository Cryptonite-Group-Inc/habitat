pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721Namable.sol";



contract Habitats is ERC721Namable, Ownable {
    // mapping to breeding information
    struct Breeding {
        bool enabled;
        uint256 price;
    }

    mapping(uint256 => Breeding) public breeding;

    constructor() public ERC721Namable("Habitats", "CAT", [], []) {
		
	}

    function _baseURI() internal view virtual returns (string memory) {
        return "https://ipfs.io/ipfs/QmZ1Wm9mzeVkLUwJ6jL7UBzwGkJsnpMQpNNmP7G8REF1Ci/";
    }


}
