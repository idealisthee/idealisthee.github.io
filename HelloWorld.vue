<template>
  <div>
    <div v-if="isInstallMetaMask">
      <div  class="flex">

        <img alt="Vue logo" src="../assets/0.png" class="imageSize">
      </div>
      <div class="fontColor fontLargeSize titleFont">
        메타마스크 설치됨
      </div>
      <div id="tempImage">

      </div>
  
      <div v-if="myAddress == null">
        <button v-on:click="connectToMetaMask">메타마스크 연결</button>
      </div>
      <div v-else>
        <!--메타마스크 연결이 되었을 때,  -->
        <div v-if="myContract == null ">
          <button v-on:click="connectToContract">컨트랙트 연결</button>
        </div>
        <div v-else>
          <!-- 컨트랙트까지 연결이 되었다 -->
          <div>
            <!-- ownerOf 구현 -->
            <input type="text" placeholder="tokenId" v-model="ownerOf_tokenId">
            <button v-on:click="requestOwnerOf">onwerof 요청</button>
            <div>
              <!-- ownerOf 결과값 -->
              {{ownerOf_result}}
            </div>
          </div>
          <!-- balanceOf 구현 -->
          <div>
            <!-- balanceOf 구현 -->
            <input type="text" placeholder="address" v-model="balanceOf_address">
            <button v-on:click="requestBalanceOf">balanceOf 요청</button>
            <div>
              <!-- balanceOf 결과값 -->
              {{balanceOf_result}}
            </div>
          </div>
          <!-- mint 구현 -->
          <div>
            <!-- mint 구현 -->
            <input type="text" placeholder="to" v-model="mint_to">
            <input type="text" placeholder="tokenId" v-model="mint_tokenId">
            <input type="text" placeholder="uri" v-model="mint_uri">
            <button v-on:click="requestMint">mint 요청</button>
            <div>
              <!-- mint 결과값 -->
              {{mint_result}}
            </div>
          </div>
          <div>
  
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      메타 마스크 설치안됨
    </div>
  </div>
</template>

<script>
import {ethers} from "ethers";
import abi from "../assets/abi.json";

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data(){
    return{
      isInstallMetaMask : window.ethereum != null 
                          && window.ethereum.isMetaMask == true,
      myAddress : null,
      myContract : null,

      ownerOf_tokenId : null,
      ownerOf_result : null,
      
      balanceOf_address : null,
      balanceOf_result : null,

      mint_to : null,
      mint_tokenId : null,
      mint_uri : null,
      mint_result : null,
    }
  },
  methods:{
    async connectToMetaMask()
    {
      console.log('click connectToMetaMask');
      var addressArray = await window.ethereum.request( { method : "eth_requestAccounts" } );
      
      console.log(addressArray);

      // 주소값이 배열로 들어있다.
      if ( addressArray.length > 0 )
      {
        this.myAddress = addressArray[0];
      }
    },
    connectToContract()
    {
      console.log("click connectToContract");
      var contractAddress = "0xbFd210e9E5559d775880C8804Ec2cC38f18504CB";

      var provider = new ethers.providers.Web3Provider(window.ethereum);
      var signer = provider.getSigner();
      this.myContract = new ethers.Contract(contractAddress, abi, signer);
      console.log(this.myContract);
    },
    async requestOwnerOf()
    {
      console.log("click requestOwnerof");
      console.log(this.ownerOf_tokenId);
      this.ownerOf_result = await this.myContract.ownerOf(this.ownerOf_tokenId);
      console.log(this.ownerOf_result);
    },
    async requestBalanceOf()
    {
      console.log("click requestBalanceOf");
      console.log(this.balanceOf_address);
      this.balanceOf_result = await this.myContract.balanceOf(this.balanceOf_address);
      console.log(this.balanceOf_result);
    },
    async requestMint()
    {
      console.log("click requstMint");
      console.log(this.mint_to);
      console.log(this.mint_tokenId);
      console.log(this.mint_uri);
      this.mint_result = await this.myContract.mint(
        this.mint_to, this.mint_tokenId, this.mint_uri);
      console.log(this.mint_result);
    }
    
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);

.imageSize
{
  width: 300px;
  height:300px;
  margin: auto;;
}
.flex
{
  display:flex;
}
.fontColor
{
  color : #85ddfd;
}
.fontLargeSize
{
  font-size : 40px;
}

.titleFont 
{
  font-family: 'Nanum Pen Script', cursive;
  text-align: center;
  border:1px solid #030be2c3;
  background-color:#030be2c3;
  /* border-radius : 10px; */
  border-bottom-right-radius: 10px;
}

</style>

