interface IBreedManager {
	function tryBreed(uint256 _sire, uint256 _matron) external returns(bool);
	function tryEvolve(uint256 _tokenId) external view returns(uint256);
}