// string replacment 
find . -type f -print0 | xargs -0 sed -i 's/hitcoinx/crixcoin/g'
find . -type f -print0 | xargs -0 sed -i 's/Hitcoinx/Crixcoin/g'
find . -type f -print0 | xargs -0 sed -i 's/HitCoinX/Crixcoin/g'
find . -type f -print0 | xargs -0 sed -i 's/HITCOINX/CRIXCOIN/g'
find . -type f -print0 | xargs -0 sed -i 's/HTX/CRIX/g'
