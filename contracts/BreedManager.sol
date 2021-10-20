pragma solidity ^0.8.4;

contract BreedManager {
    struct Incubator {
        uint256 sireGene;
        uint256 matronGene;
        uint256 brithDate;
    }

    uint256 public INCUBATION_DURATION = 60;  // 60sec for testmode
    uint256 public bebeCount;
    mapping(uint256 => Incubator) public incubators;

    function tryBreed(uint256 _sire, uint256 _matron) external returns(bool) {
        // check if incubation can be done. 
        bebeCount++;
        uint256 id = 1000 + bebeCount;
        incubators[id] = Incubator(_sire, _matron, block.timestamp);

        return true;
    }


}