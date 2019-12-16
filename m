Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD84121D42
	for <lists+linux-raid@lfdr.de>; Mon, 16 Dec 2019 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfLPW0N (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Dec 2019 17:26:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60117 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfLPW0M (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 16 Dec 2019 17:26:12 -0500
Received: from [IPv6:2601:646:8600:3281:712b:f1e1:9bde:f93a] ([IPv6:2601:646:8600:3281:712b:f1e1:9bde:f93a])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xBGMQ8SY3147819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 16 Dec 2019 14:26:09 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xBGMQ8SY3147819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019111901; t=1576535169;
        bh=ZJB055PHmo9iDwICYI7AYBZolcAXObx4boyouOn5X1o=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=d1cQ+Ax3ouEgsP1s0F56EoHLQM9PkE8zW9BOkJs49I/kHAb39uBq8UCWftjcam9oM
         msOYHJN927FbfEBZHaTgU0hRBEGSfjl0EbK1QejS3nVUVc5HoWJWjhjpUCCKUHvu7H
         e4DvXpQ/KZwVvX/JXTYkQId7xZF5+XWwXL/rtQ4gnv7Yi+R86/ohBSKFU+QfVgcrfl
         gvejw6bejBZ/9yxPfhVrWlkFKG4FtwsY5fROmlpXhk+j5wHcrOiPmTiPt7oOqX+q0V
         ti/Yd3HqOruwa8X09UQCOV6khom7eElHe/lz7XYesmn05m2B6wtXu77aSOZFZyBOZq
         1KXbnaLqxTLrA==
Date:   Mon, 16 Dec 2019 14:26:01 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
References: <20191216130933.13254-1-liuzhengyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] raid6/test: fix the compilation error and warning
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, liu.song.a23@gmail.com
CC:     linux-raid@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <D973168B-CAFB-4A5E-8896-D06B81EFF8BE@zytor.com>
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On December 16, 2019 5:09:32 AM PST, Zhengyuan Liu <liuzhengyuan@kylinos=2E=
cn> wrote:
>The compilation error is redeclaration showed as following:
>
>	In file included from =2E=2E/=2E=2E/=2E=2E/include/linux/limits=2Eh:6,
>	                 from
>/usr/include/x86_64-linux-gnu/bits/local_lim=2Eh:38,
>	                 from
>/usr/include/x86_64-linux-gnu/bits/posix1_lim=2Eh:161,
>	                 from /usr/include/limits=2Eh:183,
>	                 from
>/usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits=2Eh:194,
>	                 from
>/usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/syslimits=2Eh:7,
>	                 from
>/usr/lib/gcc/x86_64-linux-gnu/8/include-fixed/limits=2Eh:34,
>	                 from =2E=2E/=2E=2E/=2E=2E/include/linux/raid/pq=2Eh:30,
>	                 from algos=2Ec:14:
>	=2E=2E/=2E=2E/=2E=2E/include/linux/types=2Eh:114:15: error: conflicting =
types for
>=E2=80=98int64_t=E2=80=99
>	 typedef s64   int64_t;
>	               ^~~~~~~
>	In file included from /usr/include/stdint=2Eh:34,
>	                 from
>/usr/lib/gcc/x86_64-linux-gnu/8/include/stdint=2Eh:9,
>	                 from /usr/include/inttypes=2Eh:27,
>	                 from =2E=2E/=2E=2E/=2E=2E/include/linux/raid/pq=2Eh:29,
>	                 from algos=2Ec:14:
>	/usr/include/x86_64-linux-gnu/bits/stdint-intn=2Eh:27:19: note: previous
>\
>	declaration of =E2=80=98int64_t=E2=80=99 was here
>	 typedef __int64_t int64_t;
>
>The compilation warning is redefination showed as following:
>
>	In file included from tables=2Ec:2:
>	=2E=2E/=2E=2E/=2E=2E/include/linux/export=2Eh:180: warning: "EXPORT_SYMB=
OL"
>redefined
>	 #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")
>
>	In file included from tables=2Ec:1:
>	=2E=2E/=2E=2E/=2E=2E/include/linux/raid/pq=2Eh:61: note: this is the loc=
ation of the
>previous definition
>	 #define EXPORT_SYMBOL(sym)
>
>Fixes: 54d50897d54 ("linux/kernel=2Eh: split *_MAX and *_MIN macros into
><linux/limits=2Eh>")
>Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos=2Ecn>
>---
> include/linux/raid/pq=2Eh | 3 ++-
> lib/raid6/mktables=2Ec    | 2 +-
> 2 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/raid/pq=2Eh b/include/linux/raid/pq=2Eh
>index 0832c9b66852=2E=2Ee0ddb47f4402 100644
>--- a/include/linux/raid/pq=2Eh
>+++ b/include/linux/raid/pq=2Eh
>@@ -27,7 +27,6 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
>=20
> #include <errno=2Eh>
> #include <inttypes=2Eh>
>-#include <limits=2Eh>
> #include <stddef=2Eh>
> #include <sys/mman=2Eh>
> #include <sys/time=2Eh>
>@@ -59,7 +58,9 @@ extern const char raid6_empty_zero_page[PAGE_SIZE];
> #define enable_kernel_altivec()
> #define disable_kernel_altivec()
>=20
>+#undef	EXPORT_SYMBOL
> #define EXPORT_SYMBOL(sym)
>+#undef	EXPORT_SYMBOL_GPL
> #define EXPORT_SYMBOL_GPL(sym)
> #define MODULE_LICENSE(licence)
> #define MODULE_DESCRIPTION(desc)
>diff --git a/lib/raid6/mktables=2Ec b/lib/raid6/mktables=2Ec
>index 9c485df1308f=2E=2Ef02e10fa6238 100644
>--- a/lib/raid6/mktables=2Ec
>+++ b/lib/raid6/mktables=2Ec
>@@ -56,8 +56,8 @@ int main(int argc, char *argv[])
> 	uint8_t v;
> 	uint8_t exptbl[256], invtbl[256];
>=20
>-	printf("#include <linux/raid/pq=2Eh>\n");
> 	printf("#include <linux/export=2Eh>\n");
>+	printf("#include <linux/raid/pq=2Eh>\n");
>=20
> 	/* Compute multiplication table */
> 	printf("\nconst u8  __attribute__((aligned(256)))\n"

A better option would probably be to use the __u* symbols throughout, as t=
hey are part of the UABI and available both in the kernel and in userspace=
=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
