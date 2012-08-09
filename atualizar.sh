###PRIMEIRO SCRIPT DE ATUALIZACAO
#rm -rf adx
#git clone git@192.168.10.151:adx
#cd adx
#git checkout -b $1 origin/$1
#cd ..
#tar -czf adx.tar.gz adx --exclude "*\.git"
#scp adx.tar.gz manut@adx.doctum.edu.br:/var/www/var/tmp
#ssh manut@adx.doctum.com.br
###ULTIMO SCRIPT DE ATUALIZACAO

git clone git@192.168.10.151:adx adx_colegio

cd adx_colegio
git checkout colegio 
cd ..
git clone git@192.168.10.151:adx adx_graduacao
cd adx_graduacao
git checkout graduacao

cd ..
tar -czvf adx.tar.gz adx_colegio adx_graduacao --exclude "*\.git"
rm -rf adx_colegio
rm -rf adx_graduacao
scp -P 1157 adx.tar.gz adx.doctum.edu.br:/var/www/var/tmp  
ssh adx.doctum.edu.br -p 1157

