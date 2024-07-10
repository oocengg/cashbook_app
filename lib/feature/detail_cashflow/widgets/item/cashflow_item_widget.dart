import 'package:cashbook_app/core/constant/colors.dart';
import 'package:cashbook_app/core/constant/font_size.dart';
import 'package:cashbook_app/core/extensions/date_ext.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

Widget cashflowItemWidget(
  BuildContext context,
  bool pemasukan,
  String nominal,
  String deskripsi,
  DateTime tanggal,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          spreadRadius: 0,
          blurRadius: 20,
          offset: const Offset(4, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    pemasukan ? Icons.trending_up : Icons.trending_down,
                    size: 14,
                    color: pemasukan ? AppColors.green500 : AppColors.error500,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    pemasukan ? 'Pemasukan' : 'Pengeluaran',
                    style: TextStyle(
                      fontSize: AppFontSize.caption,
                      color:
                          pemasukan ? AppColors.green500 : AppColors.error500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                nominal,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.heading5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              ExpandableText(
                deskripsi,
                style: const TextStyle(
                  fontSize: AppFontSize.text,
                  color: AppColors.black,
                ),
                maxLines: 2, // Atur maksimal 3 baris
                expandText: 'Selengkapnya',
                collapseText: 'Sembunyikan',
                animation: true,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                textAlign: TextAlign.justify,
                linkColor: AppColors.blue500, // Warna teks yang dapat diperluas
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                formatDateEEEEddMMyyyy(tanggal.toString()),
                style: const TextStyle(
                  fontSize: AppFontSize.caption,
                  color: AppColors.neutral500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          pemasukan ? Icons.arrow_circle_left : Icons.arrow_circle_right,
          size: 50,
          color: pemasukan ? AppColors.green500 : AppColors.error500,
        ),
      ],
    ),
  );
}
