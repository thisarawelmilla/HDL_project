# HDL_project
Gaussian image filter

Gaussian  blur  is  an  image  processing  algorithm  used  to  smoothen  the  given  image.  The blurring  effect  is  used  to  reduce  the  sharp  edges  and  get  smooth  color  transition  at  the edges. This is done by applying the Gaussianfilter. This can be achive by convaluting the image with desired kernal. 

So we will use following as kernal for convolution.
```
| 1 2 1 | 
| 2 4 2 | 
| 1 2 1 |
```
![alt text](https://www.google.com/url?sa=i&url=https%3A%2F%2Fsupport.cognex.com%2Fdocs%2Fcvl_900%2Fweb%2FEN%2Fcvl_vision_tools%2FContent%2FTopics%2FVisionTools%2FGaussian_Convolution.htm&psig=AOvVaw31WOQiNYVLPE4fanjjOUog&ust=1595953532531000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKCmyLHs7eoCFQAAAAAdAAAAABAZ)
               
We have implemented Gassian filter in VHDL as wel as in Python to cross check.         



