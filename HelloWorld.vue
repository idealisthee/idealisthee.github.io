<template>
  <div>
    <div v-if="isInstallMetaMask">
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
      var contractAddress = "0x2fbcd49a8ed083b338abd8a5dfe321b5faeb27d3";

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
.fontColor
{
  color : #85ddfd;
}
.fontLargeSize
{
  font-size : 30px;
}

.titleFont 
{
  font-family: 'Nanum Pen Script', cursive;
  text-align: center;
  border:3px solid rgb(51, 255, 0);
  background-color:rgb(51, 255, 0);
  /* border-radius : 10px; */
  border-bottom-right-radius: 10px;
}

#tempImage
{
background-image:url("data:image/jpeg;base64,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");
background-repeat: no-repeat;

min-height:300px;

}
</style>

