      real ::   diim1(jn),  diop1(jn),  djim1(in),  djop1(in)&
          ,  diim2(jn),  diop2(jn),  djim2(in),  djop2(in)&
          ,  eiim1(jn),  eiop1(jn),  ejim1(in),  ejop1(in)&
          ,  eiim2(jn),  eiop2(jn),  ejim2(in),  ejop2(in)&
          , v1ii  (jn), v1iop1(jn), v1jim1(in), v1jop1(in)&
          , v1iim1(jn), v1iop2(jn), v1jim2(in), v1jop2(in)&
          , v2iim1(jn), v2iop1(jn), v2ji  (in), v2jop1(in)&
          , v2iim2(jn), v2iop2(jn), v2jim1(in), v2jop2(in)&
          , v3iim1(jn), v3iop1(jn), v3jim1(in), v3jop1(in)&
          , v3iim2(jn), v3iop2(jn), v3jim2(in), v3jop2(in)&
          ,emfii  (jn),emfiop1(jn),emfji  (in),emfjop1(in)&
          ,emfiim1(jn),emfiop2(jn),emfjim1(in),emfjop2(in)&
          ,emfiim2(jn),emfiop3(jn),emfjim2(in),emfjop3(in)&
          , b3iim1(jn), b3iop1(jn), b3jim1(in), b3jop1(in)&
          , b3iim2(jn), b3iop2(jn), b3jim2(in), b3jop2(in)&
          , eriim1(jn), eriop1(jn), erjim1(in), erjop1(in)&
          , eriim2(jn), eriop2(jn), erjim2(in), erjop2(in)

      integer ::  niib(jn),  noib(jn),  nijb(in),  nojb(in)&
           ,  miib(jn),  moib(jn),  mijb(in),  mojb(in)&
           ,  liib(jn),  loib(jn),  lijb(in),  lojb(in)&
           , b3iib(jn), b3oib(jn), b3ijb(in), b3ojb(in)

      common /bndryr/&
        diim1,  diim2,  diop1,  diop2,  djim1,  djim2,  djop1,  djop2&
     ,  eiim1,  eiim2,  eiop1,  eiop2,  ejim1,  ejim2,  ejop1,  ejop2&
     , v1ii  , v1iim1, v1iop1, v1iop2, v1jim1, v1jim2, v1jop1, v1jop2&
     , v2iim1, v2iim2, v2iop1, v2iop2, v2ji  , v2jim1, v2jop1, v2jop2&
     , v3iim1, v3iim2, v3iop1, v3iop2, v3jim1, v3jim2, v3jop1, v3jop2&
     ,emfii  ,emfiim1,emfiop1,emfiop2,emfji  ,emfjim1,emfjop1,emfjop2&
             ,emfiim2        ,emfiop3        ,emfjim2        ,emfjop3&
     , b3iim1, b3iim2, b3iop1, b3iop2, b3jim1, b3jim2, b3jop1, b3jop2&
     , eriim1, eriim2, eriop1, eriop2, erjim1, erjim2, erjop1, erjop2

      common /bndryi/   niib,   noib,   nijb,   nojb&
                   ,   miib,   moib,   mijb,   mojb&
                   ,   liib,   loib,   lijb,   lojb&
                   ,  b3iib,  b3oib,  b3ijb,  b3ojb
