Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360BC1F602F
	for <lists+linux-raid@lfdr.de>; Thu, 11 Jun 2020 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKCz7 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 10 Jun 2020 22:55:59 -0400
Received: from mx0b-0019cd01.pphosted.com ([67.231.157.222]:33468 "EHLO
        mx0b-0019cd01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgFKCz7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 10 Jun 2020 22:55:59 -0400
Received: from pps.filterd (m0073870.ppops.net [127.0.0.1])
        by mx0b-0019cd01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05B2sFbi026647
        for <linux-raid@vger.kernel.org>; Wed, 10 Jun 2020 22:55:58 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-0019cd01.pphosted.com with ESMTP id 31g80qv0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-raid@vger.kernel.org>; Wed, 10 Jun 2020 22:55:58 -0400
Received: by mail-qk1-f200.google.com with SMTP id 140so3855051qko.23
        for <linux-raid@vger.kernel.org>; Wed, 10 Jun 2020 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fordham-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9gr5TLgHc+p1JdTYNAGQhgqTDAutiHR09Y8WFXrJeUg=;
        b=JhryJ+i7UC8HIvhcmvzYc3ZXhFeIb5LE7ZcsYdqX7kJv7I/2ULairvnKdYeL5s9DPp
         EhLn3zfrJf/rnjK8i88PKW+RgsBQQD9NcN9kavI27fu7SSOdyhsnOiAgJBVNj8ukjYZJ
         sCN7jdsQRt792A4bpFu/mswbVarHGkeuLByqBC/XK9irtBvwUiWcBMppYehJZNICNleH
         K4+/qxfyXuviUMMXydjrCqYt/zqv3/QWiVwGpca/+vYhzQYdVtduNQJgJ1p01LwO/kw9
         kRo3EN2dNbL1Jm7oLU6wNtGkrcJae9W4+m8DLqe8nDZ2d63n5jcu/pFsOMERinzn/uxk
         ykrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9gr5TLgHc+p1JdTYNAGQhgqTDAutiHR09Y8WFXrJeUg=;
        b=jwCRnc+7QBDRgVepFBWvEwxnOdNOmMYh5iOHJ5jjC7nMCDQ+K7ovwBSo6tdcHnrvPA
         0CIwxJgB8Efdb+i33laqeq9siLZPSPfGg7EwlRz4yWE6MTb1xdpAtPsZve0Kjo7gsozY
         1Wz5xTAX6UCl2d9lEx63JnEY9xrNy5id2rabiuS5JljwV2BxXyskCXMH3BAtzrFaxMgn
         QjahnkyosPzsCTK1nD5LsABPTW/919yyz/KL5DYeSXvzJloPmJdKeC+loOOpGuTBcez4
         aD/e8uqSh/i34TS/IT3q/bvmjyiINPY0qK/gyx2vcJBg2vnenlmIqsldLnjlKm4PIbl1
         oWlA==
X-Gm-Message-State: AOAM531JjoXgXUgk1wFoK2vNhXF8loqb+apvhY/JykHEDByRuKmvZZ/D
        6Y6BnyuaOKHK4koW1jrNSnlriHZo9JTC8Mtr1BHDQklrB5uno+yKkpb4R0cOjhnuZDlR0WbBpw9
        Q/ZJ5fq1zE7ehBkWkYV/kUaSkO/LkLt3HiIg=
X-Received: by 2002:ac8:7303:: with SMTP id x3mr6282509qto.44.1591844157158;
        Wed, 10 Jun 2020 19:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEpcNiyUZG6u+KA75Yo4E84/6xRYjjWl2fWTNeY/nVu8dBO094wPPTITz1/gfcXJSLvHbE/SIYtABmCiKG7rQ=
X-Received: by 2002:ac8:7303:: with SMTP id x3mr6282484qto.44.1591844156452;
 Wed, 10 Jun 2020 19:55:56 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Kudyba <rkudyba@fordham.edu>
Date:   Wed, 10 Jun 2020 22:55:45 -0400
Message-ID: <CAFHi+KQCDok8bRTWTZcDGpOkdBvbH+szC5=qK0PZz2okdULsNQ@mail.gmail.com>
Subject: Recovering a failed software RAI, where does parallel -j0 dd to?
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=484 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110021
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I'm trying to go through
https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID
echo $DEVICES
/dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1
parallel -j0 dd if={} of=/dev/null bs=1M ::: $DEVICES

dd: error reading '/dev/sdd1': Input/output error
23510+1 records in
23510+1 records out
24652464128 bytes (25 GB, 23 GiB) copied, 173.685 s, 142 MB/s

Or is that just doing a scan and just checking which drive are bad? I
sure would like to get that 25GB back. Is that possible?

I also see this:
ddrescue -r 3 /dev/old /dev/new my_log
ddrescue -R -r 3 /dev/old /dev/new my_log

Can I just use a mount point for /dev/new?
