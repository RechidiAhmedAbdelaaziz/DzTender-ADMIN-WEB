part of '../screen/tenders.screen.dart';

class _TenderTitle extends StatelessWidget {
  const _TenderTitle(this._tender);

  final TenderModel _tender;

  @override
  Widget build(BuildContext context) {
    final isStartup = _tender.isStartup ?? false;
    final imgUrl = _tender.announcer?.imageUrl ?? '';
    final title = _tender.title ?? '';
    return Row(
      crossAxisAlignment: isStartup
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        widthSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.spMax,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isStartup)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'Startup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.spMax,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
