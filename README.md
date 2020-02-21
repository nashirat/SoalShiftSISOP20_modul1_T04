# Penyelesaian dan Penjelasan Soal Shift Sistem Operasi Modul 1

## Teknologi Informasi Kelompok T04
__Muhammad Sulthon Nashir (05311840000011)__

__Bagus Farhan Abdillah (05311840000016)__

### SOAL 1

#### Berikut adalah soal 1 :

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :
1.  Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit
2. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a
3. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b

Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung

#### Link code soal 1 :

##### Source Code : [Soal 1.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal1/soal1.sh)
##### Data : [Sample-Superstore.tsv](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal1/Sample-Superstore.tsv)

#### Penyelesaian dan penjelasan soal 3 :
```bash
wd=`pwd`
```
* __"pwd"__ adalah print working directory, kita masukkan ke variable __wd__

##### 1a.
```bash
a=`awk -F "\t" 'NR > 1 {seen[$13]+=$NF} END{for (i in seen) printf "%s,%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "," -k 2 | awk -F "," 'NR < 2 {printf "%s\n", $1}'`
```
 * Kita buat line awk dengan pemisah yaitu tab __("\t")__. Setelah itu gunakan __seen__ untuk menjumlahkan tab profit yang kebetulan tab terakhir, sehingga kita bisa gunakan __NF__. Kita __"print"__ hasilnya.
 * Setelah itu __pipe__ lalu __sort__ menggunakan __-g__ karena __profit__ bertipe __float__.
 * Setelah itu __pipe__ lalu print dengan menggunakan __awk__ dengan __NR < 2__, karena kita hanya membutuhkan 1 output. Kita outputkan sebagai variabel __a__.

 ##### 1b.
 ```bash
 b=`awk -F "\t" -v a=$a '{if (match($13, a)) seen[$11]+=$NF} END {for (i in seen) printf "%s,%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t  "," -k 2 | awk -F "," 'NR < 3 {printf "%s\n", $1}'`
 ```
 * Logika yang digunakan disini sama persis dengan soal 1a, hanya kita tambahkan saja __match__ untuk tab ke __13__ yang isinya adalah __region__, dengan logika jika __tab 13__ adalah __a__, maka jumlahkan profit menggunakan __seen__ untuk setiap __seen__ yang berbeda.
 * __NR < 3__ karena kita disini membutuhkan 2 output, yang kita simpan dalam variabel __b__.
```bash
s1=`echo $b | awk -F " " '{printf "%s", $1}'`
s2=`echo $b | awk -F " " '{printf "%s", $2}'`
```
* Karena ada 2 output, maka kita pisah menggunakan kode diatas. Kita simpan __state 1__ ke dalam variabel __s1__, state dua ke dalam variabel __s2__.
 ##### 1c.
 ```bash
 c1=`awk -F "\t" -v s1=$s1 '{if (match($11, s1)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`
 c2=`awk -F "\t" -v s2=$s2 '{if (match($11, s2)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`

 c3=`awk -F "\t" -v s1=$s1 -v s2=$s2 '{if (match($11, s1)||match($11, s2)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`
 ```
 * Karena ada dua state, maka kita akan mencari __10 yang paling rendah profitnya dalam masing-masing state serta 10 yang terendah dari gabungan kedua state__.
 * Logika yang digunakan sama persis dengan soal 1b, yang berbeda hanya kita akan print 10, sehingga __NR < 11__ dan akan ada dua output yaitu __nama produk($1)__ dan __value produk($2)__.
 * Untuk profit dari kedua state, kita hanya perlu menambahkan __||__ dalam fungsi __match__, agar nilai dari kedua state bisa dihitung bersamaan.
 * Pada soal 1c kita menggunakan __?__ sebagai separator hasil karena tidak ada produk yang terdapat simbol __?__ didalamnya.


 ## SOAL 2
 #### Berikut adalah soal 2 :
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.

HINT: enkripsi yang digunakan adalah caesar cipher.

*Gunakan Bash Script

#### Link code soal 2 :
##### Source Code : [soal2.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal2/soal2.sh) - Soal 2a & 2b
##### Source code : [soal2_enkripsi.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal2/soal2_enkripsi.sh) -  Soal 2c
##### Soure code  : [soal2_dekripsi.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal2/soal2_dekripsi.sh) -  Soal 2d
#### Penyelesaian dan penjelasan soal 3 :
##### 2a. dan 2b.
```Bash
pass="`cat /dev/urandom | tr -cd 'a-zA-Z0-9' | fold -w 28 | head -n 1`"
```
* Kita akan gunakan __urandom__ untuk menghasilkan password acak, dengan batasan hanya berupa __alphanumeric__ menggunakan fungsi __tr -cd__, lalu pangkas hanya 28 karakter dengan menggunakan __fold__, lalu ambil 1 saja dengan menggunakan __head__.

```Bash
name="`echo $1 | tr -cd 'a-zA-Z'`"
echo $pass > $wd/$name.txt
```
* Setelah itu lakukan __tr__ untuk menghapus judul yang tidal alphabet
* Dengan menggunakan __>__ masukkan __$pass__ ke file yang bernama berdasarkan __$name__
```Bash
namesum="`md5sum $name.txt | cut -d ' ' -f 1`"
echo "$namesum",`date +"%H"` >> $wd/data.csv
```
* Lakukan __hashing__ menggunakan __md5sum__ untuk keperluan enkripsi dan dekripsi nanti. Cut ekstensi file pada hasil hashing menggunakan __-cut__
* Masukkan hasil __hashing__ dan __date__ yang sudah dispesifikasikan agar hanya jam saja ke __data.csv__. __data.csv__ ini akan kita pakai sebagai tempat untuk mengambil waktu pembuatan file.

##### 2c.
```Bash
name="${1%.*}"
namesum="`md5sum $1 | cut -d ' ' -f 1`"
key=`awk -v ns=$namesum -F "," '{if (match($1, ns))print$2}' $wd/data.csv`
```

* Potong ekstensi file dengan menggunakan __%.*__.
* Cek pada file __data.csv__ apakah ada __hash__ yang sama dengan file yang diinputkan dalam argumen, jika ada maka gunakan jamnya sebagai __key__

```Bash
ds=$(echo {a..z} | sed -r 's/ //g')
dc=$(echo $ds | sed -r "s/^.{$key}//g")$(echo $ds | sed -r "s/.{$( expr 26 - $key )}$//g")
en=`echo $name | tr '[A-Z]' $ds | tr $ds $dc`
```
* __ds__ berfungsi untuk menghapus karakter __spasi(" ")__ pada __echo {a..}__.
* __dc__ dibagi menjadi dua bagian yaitu yang pertama untuk memotong __echo {a..z}__ sesuai dengan __$key__ dari depan. Contoh jika __$key__ adalah __2__ maka __"abcdefghijklmnopqrstuvwxyz"__ akan menjadi __"cdefghijklmnopqrstuvwxyz"__.
* Bagian kedua untuk memotong huruf lain selain tergantung dari __$key__. __"abcdefghijklmnopqrstuvwxyz"__ akan menjadi __"ab"__ jika __$key__ adalah __2__.
* Kedua bagian tersebut akan digabung sehingga __dc__ adalah __"cdefghijklmnopqrstuvwxyzab"__ jika __$key = 2__.
* Selanjutnya dengan menggunakan fungsi __tr__, __$name__ akan di translate menurut __ds__ dan __dc__, dengan terlebih dahulu huruf kapital ditranslate ke huruf kecil.

```Bash
mv $wd/$name.txt $wd/$en.txt
```
* Ubah nama file dengan hasil enkripsi __$en__.
##### 2d.
```Bash
name="${1%.*}"
namesum="`md5sum $1 | cut -d ' ' -f 1`"
key=`awk -v ns=$namesum -F "," '{if (match($1, ns))print$2}' $wd/data.csv`
ds=$(echo {a..z} | sed -r 's/ //g')
dc=$(echo $ds | sed -r "s/^.{$key}//g")$(echo $ds | sed -r "s/.{$( expr 26 - $key )}$//g")
de=`echo $name | tr '[A-Z]' $ds | tr $dc $ds`

mv $wd/$name.txt $wd/$de.txt
```
* Karena __md5sum (hashing)__ menggunakan isi file bukan nama file, metode dekripsi sama persis dengan metode enkripsi. Kita hanya perlu membalik posisi __ds__ dan __dc__ sehingga rotasi terbalik.

## SOAL 3

#### Berikut adalah soal 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk

menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak".

Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".

*Gunakan Bash, Awk dan Crontab

#### Link code soal 3 :
##### Source Code : [soal3.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal3/soal3.sh) - Soal 3a
##### crontab : [crontabsoal3](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal3/crontabsoal3) - Soal 3b
##### Identifikasi : [soal3_ident.sh](https://github.com/nashirat/SoalShiftSISOP20_modul1_T04/blob/master/soal3/soal3_ident.sh) - Soal 3c
#### Penyelesaian dan penjelasan soal 3 :

##### 3a.
```Bash
last=`ls $wd | grep "pdkt_kusuma" | cut -d "_" -f 3 | sort -n | tail -1`
```
* Code diatas berfungsi untuk mengambil nomor urut terakhir dari banyak file __pdkt_kusuma_n__ yang ada. Setelah didapat simpan dalam __$last__.

```Bash
if [[ $last =~ [^0-9] ]]
then
  last=0
fi
```
* Kerena jika file __pdkt_kusuma_n__ belum terdownload sama sekali, maka __last__ akan mempunyai nilai __tidak ada ""__. Oleh karena itu, kita gunakan __if__ agar jika __last__ tidak ada, maka __last__ adalah __0__.
```Bash
a=`expr $last + 1`
b=`expr $last + 28`

for ((i=a;i<=b;i++))
do
  wget -O $wd/"pdkt_kusuma_$i" https://loremflickr.com/320/240/cat -a $wd/wget.log
done
```
* Kerena kita harus download 28 gambar, maka kita akan menggunakan __((i=a;i<=b;i++))__. Jika kita menjalankan script dua kali, maka download pada batch selanjutnya harus bernama __pdkt_kusuma_29__. Oleh karena itu, kita set __a__ dan __b__ sebagai batasan berdasarkan __last__.
* Output download akan bernama __pdkt_kusuma_$i__ dengan menggunakan command __-O__, log download akan disimpan dalam __wget.log__ dengan menggunakan command __-a__.

##### 3b.
```
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
5 6,14,22 * * 0-5 cd /home/nash/Tugas/shift1/soal3 && ./soal3.sh
```
* Crontab untuk soal 3. Pastikan melakukan __chmod +x__ agar __script__ bisa diakses dan dijalankan oleh crontab.

##### 3c.
```Bash
if [ ! -d $wd/kenangan ];
then
mkdir -p $wd/kenangan;
fi

if [ ! -d $wd/duplicate ];
then
mkdir -p $wd/duplicate;
fi
```
* Untuk membuat folder __kenangan__ dan __duplicate__ bila belum ada.
```Bash
a=`ls $wd | grep "pdkt_kusuma" | cut -d "_" -f 3 | sort -n | tail -1`
ar=""
```
* Set dua variabel yaitu __a__ sebagai nomor urut/file terakhir sehingga __for loop__ bisa dijalankan sampai __a__ dan __ar=""__ sebagai __array__ dengan isi __""(kosong)__.

```Bash
for ((i=1;i<=a;i++))
do
  loc="`grep "Location" $wd/wget.log | cut -d "_" -f 3 | head -$i | tail -1`"
  flag=`echo -e $ar | awk -v loc=$loc 'BEGIN {flag=0} {if (loc==$0) flag=1} END {printf "%d", flag}'`
```
* Untuk __i__ sampai dengan __a__ lakukan set variabel __loc__ dimana __$i__ dalam __loc__ merupakan nomor urut file, sehingga kita bisa mengambil hanya satu file dari __wget.log__ dengan menggunakan __head -$i__ dan __tail -1__.
* Echo __array__ lalu dengan menggunakan __awk__ lakukan set __flag__, dengan __flag__ awal yaitu __0__. Jika __loc__ sama dengan salah satu __line__ di __array__, maka __flag__ diubah ke __1__.
```Bash
if [[ $flag == 0 ]]
then
  ar="$ar$loc\n"
  mv $wd/pdkt_kusuma_$i $wd/kenangan/kenangan_$i
else
  mv $wd/pdkt_kusuma_$i $wd/duplicate/duplicate_$i
fi
done
```
* Jika __flag = 0__ maka hapus __array__ dan masukkan __loc__ dengan tambahan __\n__ (karena __head__ dan __tail__ hanya berfungsi pada line), sehingga file yang dijadikan "patokan" berubah ke file berdasarkan line selanjutnya. Pindah file __pdkt_kusuma_$i ke __kenangan__ dengan nama kenangan$i.
* jika __flag != 0__ maka file adalah duplikat dari __loc__ yang sedang diproses, sehingga pindah ke folder __duplicate__.

```Bash
cat $wd/wget.log >> $wd/wget.log.bak
rm $wd/wget.log
```
* Tamplikan __wget.log__ lalu masukkan per line dengan menggunakan __>>__ ke __wget.log.bak__, lalu hapus __wget.log__.
