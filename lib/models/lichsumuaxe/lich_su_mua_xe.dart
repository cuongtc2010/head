import 'package:flutter/material.dart';

class LichSuMuaXe {
  final String id;
  final String id_dong_bo_phan_mem;
  final String ngay;
  final String tu_ngay;
  final String den_ngay;
  final String phan_loai_noi_dung;
  final String id_khach_hang;
  final String ghi_chu;
  final String noi_dung_tong_quat;
  final String noi_dung_chi_tiet;
  final int is_delete;

  LichSuMuaXe(
      {this.id,
      this.id_dong_bo_phan_mem,
      this.ngay,
      this.tu_ngay,
      this.den_ngay,
      this.phan_loai_noi_dung,
      this.id_khach_hang,
      this.ghi_chu,
      this.noi_dung_tong_quat,
      this.noi_dung_chi_tiet,
      this.is_delete});

  factory LichSuMuaXe.fromJson(Map<String, dynamic> json) {
    return LichSuMuaXe(
      id:json['id'].toString(),
      id_dong_bo_phan_mem: json["id_dong_bo_phan_mem"].toString(),
      ngay: json["ngay"].toString(),
      tu_ngay: json["tu_ngay"].toString(),
      den_ngay: json["den_ngay"].toString(),
      phan_loai_noi_dung: json["phan_loai_noi_dung"].toString(),
      id_khach_hang: json["id_khach_hang"].toString(),
      ghi_chu: json["ghi_chu"].toString(),
      noi_dung_tong_quat: json["noi_dung_tong_quat"].toString(),
      noi_dung_chi_tiet: json["noi_dung_chi_tiet"].toString(),
      is_delete: json["is_delete"]
    );
  }
}