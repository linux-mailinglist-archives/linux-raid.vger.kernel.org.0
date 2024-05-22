Return-Path: <linux-raid+bounces-1533-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8158CBD4A
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2024 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D2B1F22C07
	for <lists+linux-raid@lfdr.de>; Wed, 22 May 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10280C02;
	Wed, 22 May 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gxwt5p/d"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E480039
	for <linux-raid@vger.kernel.org>; Wed, 22 May 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367904; cv=none; b=WOVqS4Be9EG+hhVDQ7pc3zqC6yGmn8RmbR8rvEIXmlY19OvPaseoFG7M2AUj0MLJk7zln2NRE7jj/nyEAalixjDd4B0Zp6F92ywRrT3WaezYrMXGpj1BYM9365GVrca1sTjlI1lkiP8FEqkFiXXGtGh8v+EP1+bfvJgW7LqbyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367904; c=relaxed/simple;
	bh=vPnqFPNvWOcZVPDfSRKzJmhyIb0hT5Qh3BzPNZuApmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUvGKFODcqEKyLm5aVR9tiUJXIa908v+9K77NntGjsnFrwAmQ9bXkmsyqNgvBzDjWY0ZWnhk1xLi3Lfi4JAUJrAHDuh2019YTbdi5a+pgpyPeYsAKQFTgeaqZsaPGeVMBlpFwzLQQ+jb/x35fx6dIMgHKmpP2N/5jPaz9DHb8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gxwt5p/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716367902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ce6yvrzH3UM/tiCTa9fVHso6tB/+62b1/FqPOe0gQU=;
	b=Gxwt5p/dJszeqjzLL3QOZaLLutKNhFJeqcrK73UJCcLayMpSxLa7pCWSCjJ2yiXhrBh/zd
	wT6zacR/AWkU1aq3+fk03n0p0/UHGqwag3MZKHY1aMIu9bcl5O0brune6//Q0Jv1c0yoM/
	SKRYsKbiYcoVHF0JlqccIvf7lo2terw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-XMPooH4-PPepar5f5H8ueg-1; Wed, 22 May 2024 04:51:41 -0400
X-MC-Unique: XMPooH4-PPepar5f5H8ueg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1919680118E;
	Wed, 22 May 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBF50C15BB1;
	Wed, 22 May 2024 08:51:38 +0000 (UTC)
From: Xiao Ni <xni@redhat.com>
To: mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	heinzm@redhat.com,
	ncroxon@redhat.com
Subject: [PATCH 14/19] mdadm/tests: 05r6-bitmapfile
Date: Wed, 22 May 2024 16:50:51 +0800
Message-Id: <20240522085056.54818-15-xni@redhat.com>
In-Reply-To: <20240522085056.54818-1-xni@redhat.com>
References: <20240522085056.54818-1-xni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

It's not right to compare bitmap bits with a number after io comes.
Because maybe those bits are already flused. Remove the related
tests.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 tests/05r6-bitmapfile | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tests/05r6-bitmapfile b/tests/05r6-bitmapfile
index d11896db221c..df66e59462cb 100644
--- a/tests/05r6-bitmapfile
+++ b/tests/05r6-bitmapfile
@@ -11,21 +11,20 @@ mdadm -S $md0
 
 mdadm --assemble $md0 --bitmap=$bmf $dev1 $dev2 $dev3 $dev4
 testdev $md0 2 $mdsize1 512
-dirty1=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
 sleep 4
-dirty2=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
+dirty1=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
 
-if [ $dirty1 -lt 400 -o $dirty2 -ne 0 ]
-then  echo >&2 "ERROR bad 'dirty' counts: $dirty1 and $dirty2"
+if [ $dirty1 -ne 0 ]
+then  echo >&2 "ERROR bad 'dirty' counts: $dirty1"
   exit 1
 fi
 mdadm $md0 -f $dev3
 testdev $md0 2 $mdsize1 512
 sleep 4
-dirty3=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
-if [ $dirty3 -lt 400 ]
+dirty2=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
+if [ $dirty2 -lt 400 ]
 then
-   echo >&2 "ERROR dirty count $dirty3 is too small"
+   echo >&2 "ERROR dirty count $dirty2 is too small"
    exit 2
 fi
 
@@ -35,14 +34,12 @@ mdadm --assemble -R $md0 --bitmap=$bmf $dev1 $dev2 $dev4
 mdadm --zero $dev3 # force --add, not --re-add
 mdadm $md0 --add $dev3
 check recovery
-
-dirty4=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
 check wait
 sleep 4
-dirty5=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
+dirty3=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
 
-if [ $dirty4 -lt 400 -o $dirty5 -ne 0 ]
-then echo echo >&2 "ERROR bad 'dirty' counts at end: $dirty4 $dirty5"
+if [ $dirty3 -ne 0 ]
+then echo echo >&2 "ERROR bad 'dirty' counts at end: $dirty3"
   exit 1
 fi
 
-- 
2.32.0 (Apple Git-132)


