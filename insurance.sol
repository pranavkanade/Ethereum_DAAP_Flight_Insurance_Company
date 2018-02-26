pragma solidity ^0.4.0;

contract Insurance {
  
    uint ftime;
    uint fid;
    address add;
   
    event Success(
       address _add,
       uint _fid,
       uint _ftime
    );

    function flightDelayInsurance(address _addr, uint _fid, uint _ftime) public {
        fid = _fid;
        ftime = _ftime;
        add = _addr;

        if(_fid == 1234 && 1 <= _ftime - 2){
            Success(1, _fid, _ftime);
        }
        if(_fid == 1235 && 2 <= _ftime - 2){
            Success(1, _fid, _ftime);
        }
        if(_fid == 1236 && 3 <= _ftime - 2){
            Success(1, _fid, _ftime);
        }
        if(_fid == 1237 && 4 <= _ftime - 2){
            Success(1, _fid, _ftime);
        }
        if(_fid == 1238 && 5 <= _ftime - 2){
            Success(1, _fid, _ftime);
        }   
        else{
            Success(0, _fid, _ftime);
        }
    }
}