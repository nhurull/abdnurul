-- Nama: Nurul khatima
-- NIM : 22241029

-- akses database
USE mart_undikma;

-- soal 1

SELECT nama_produk, 
       SUM(qty*(harga - (diskon_persen / 100) * harga)) AS pendapatan
FROM tr_penjualan_dqlab
GROUP BY nama_produk
ORDER BY pendapatan DESC;

-- soal 2

SELECT np.kategori_produk, 
       SUM(tp.qty * (tp.harga - (tp.diskon_persen / 100) * tp.harga)) AS Pendapatan,
       CASE 
           WHEN SUM(tp.qty * (tp.harga - (tp.diskon_persen / 100) * tp.harga)) >= 900000 THEN 'Target Archived'
           WHEN SUM(tp.qty * (tp.harga - (tp.diskon_persen / 100) * tp.harga)) < 900000 THEN 'Less Performance'
           ELSE 'Follow Up'
       END AS status
FROM tr_penjualan_dqlab tp
JOIN ms_produk_dqlab np
ON tp.kode_produk = np.kode_produk
GROUP BY np.kategori_produk
HAVING status = 'Follow Up'
LIMIT 3;

-- SOAL 3
SELECT 
  mp.nama_pelanggan,
  mp.alamat
FROM 
  tr_penjualan_dqlab AS tp
RIGHT JOIN
  ms_pelanggan_dqlab AS mp
  ON mp.kode_pelanggan = tp.kode_pelanggan
WHERE tp.qty IS NULL;



