pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./IBreedManager.sol";
import "./ERC721Namable.sol";



contract Habitats is ERC721Namable, Ownable {
    // mapping to breeding information
    struct Breeding {
        bool enabled;
        uint256 price;
    }

    IBreedManager breedManager;

    mapping(uint256 => Breeding) public breeding;

    constructor() public ERC721Namable("Habitats", "CAT", [], []) {
		
	}

    function _baseURI() internal view virtual returns (string memory) {
        return "https://ipfs.io/ipfs/QmZ1Wm9mzeVkLUwJ6jL7UBzwGkJsnpMQpNNmP7G8REF1Ci/";
    }

    function mint(uint256 _tokenId, uint256 _genes, bytes calldata _sig) external {
		require(keccak256(abi.encodePacked(id, _genes)).toEthSignedMessageHash().recover(_sig) == SIGNER, "Sig not valid");
		_mint(msg.sender, id);
	}

    function setBreedingManager(address _manager) external onlyOwner {
		breedManager = IBreedManager(_manager);
	}
}
