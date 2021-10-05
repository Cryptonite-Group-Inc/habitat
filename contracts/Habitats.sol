pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./IBreedManager.sol";
import "./ERC721Namable.sol";



contract Habitats is ERC721Namable, Ownable {
    // mapping to breeding information
    struct Habitat {
        uint256 breed_price;
		uint256 genes;
		uint256 bornAt;
        bool enabled;
	}

    IBreedManager breedManager;
    uint256 public bebeCount;

    mapping(uint256 => Breeding) public habitat;

    // Events
	event HabitatIncubated (uint256 tokenId, uint256 matron, uint256 sire);
	event HabitatBorn(uint256 tokenId, uint256 genes);
	event HabitatAscended(uint256 tokenId, uint256 genes);

    constructor() public ERC721Namable("Habitats", "CAT", [], []) {
		
	}

    function _baseURI() internal view virtual returns (string memory) {
        return "https://ipfs.io/ipfs/QmZ1Wm9mzeVkLUwJ6jL7UBzwGkJsnpMQpNNmP7G8REF1Ci/";
    }


    /**
        gene representation in uint256
        species (1) | gender (1) | background (2) | background color (3) | Outline color (3) | inline color (3) | eye (2) | mouth (3) | accessory (4) | reservatuib
     */
    function mint(uint256 _tokenId, uint256 _genes, bytes calldata _sig) external {
		require(keccak256(abi.encodePacked(id, _genes)).toEthSignedMessageHash().recover(_sig) == SIGNER, "Sig not valid");
		_mint(msg.sender, id);

        emit HabitatAscended(id, _genes);
	}

    function setBreedingManager(address _manager) external onlyOwner {
		breedManager = IBreedManager(_manager);
	}

    function breed(uint256 _sire, uint256 _matron) external {
		require(ownerOf(_sire) == msg.sender && ownerOf(_matron) == msg.sender);
		require(breedManager.tryBreed(_sire, _matron));

		bebeCount++;
		uint256 id = 1000 + bebeCount;
		habitat[id] = habitat(0, 0, block.timestamp, false);
		_mint(msg.sender, id);

        emit HabitatIncubated(id, _matron, _sire);
	}

	function evolve(uint256 _tokenId) external {
		require(ownerOf(_tokenId) == msg.sender);
		Habitat storage habitat = habitat[_tokenId];
		require(habitat.genes == 0);

		uint256 genes = breedManager.tryEvolve(_tokenId);
		habitat.genes = genes;

        emit HabitatBorn(_tokenId, genes);
	}
}
