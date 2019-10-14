Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C27D5EA1
	for <lists+linux-raid@lfdr.de>; Mon, 14 Oct 2019 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfJNJVF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 05:21:05 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37503 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbfJNJVF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Oct 2019 05:21:05 -0400
Received: by mail-wr1-f43.google.com with SMTP id p14so18790542wro.4
        for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2019 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=P7Nz0Q8mzXkdZAtxRHy5NAQeCJiLfp5DL+9p6sH6fzA=;
        b=l02YDxdRwMjz8ZTMoglXFwbU2vVN5tvUTtdCx/wgd9fHs1b4Jlj2mU0beWILTdONfP
         dLEXvYRcr+TL+avZUomGgZziGjAqVK+vkUUYpjFchWCLEl7LJyjR/PW3X82FeH0kWK1s
         DVtW887dZMaxs8E90xUhKX+LZDvYX8cFokVQBG33PEdAMVFvjWb2/f+whx/0OC1gIl/u
         Ind63zwOHKss/QKcs0wnJkvfjZ+RXZ+HEFFTr/tTqETXLPXxFZWzys4I2FfMZQjb2fx2
         lSvRAeD8R0SwwPLTcqdDqKC0Vr8l+pVKat1LmmO6FDWtOa3SUGGoNCZAi81UPnMmfqid
         x5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=P7Nz0Q8mzXkdZAtxRHy5NAQeCJiLfp5DL+9p6sH6fzA=;
        b=AI+meiqDGtrAwYnr/BOjwsafW5hezyWb8JO8kOhpJsjS25OOt4kbhBGqu1k5sYC/YW
         0C3Tasxikj0RLU+eFvaFwGrXoiq/oFeMlKsDefOYIaWTlk2yfPh2ERulcbRhAG+H/KJ6
         cttOVc4074O0VfU1fB2sMpZGnHl4WIJEqafHA7Up8V5SP46fP24trEfUN+qSC5xqsWnU
         pnud+o1VRPRZ+l1/KibIVzxyeRq9dVZZThGOQnDRaf3m+eRoLXkR7g8Lm3bD3uPs2wC/
         vXIxeBkdPdpL3gzJvkGp8CR8l4NEOSJ/7kEBQyQcEpFjUZpiErLnaZchVtlHY6M0SaQ4
         Rtuw==
X-Gm-Message-State: APjAAAXQgWzF6uAm+YbrrIqNfQETLcsdIunSbQ5Z19wTEb3mGLJMXVns
        B6aFk9ZJNSN5JERVRnnAckkDhlcFS40=
X-Google-Smtp-Source: APXvYqy9Cm1BjP/dVRN8EETxM1QOxdfygHp8FI2kZLYcYbEyh//pwxdNjaMacS1iWFxTZWr7cGc5CA==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr26098969wri.341.1571044861858;
        Mon, 14 Oct 2019 02:21:01 -0700 (PDT)
Received: from argo.dxprod.sympato.ch (bsse-bs-dock-128-90.ethz.ch. [129.132.128.90])
        by smtp.googlemail.com with ESMTPSA id a3sm15580081wmj.35.2019.10.14.02.21.00
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 02:21:01 -0700 (PDT)
Subject: Re: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
To:     linux-raid <linux-raid@vger.kernel.org>
References: <CAPhsuW4gLcQU+6BJWJ7Lda=d5UFjNk5R5KmQNp-BN8X+CnXwnw () mail !
 gmail ! com>
From:   DrYak <doktor.yak@gmail.com>
Autocrypt: addr=doktor.yak@gmail.com; prefer-encrypt=mutual; keydata=
 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 Nw==
Message-ID: <b9b8f42f-cc55-b165-2430-f0c9731002d1@gmail.com>
Date:   Mon, 14 Oct 2019 11:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4gLcQU+6BJWJ7Lda=d5UFjNk5R5KmQNp-BN8X+CnXwnw () mail !
 gmail ! com>
Content-Type: multipart/mixed;
 boundary="------------4F56D0A3E9F3FFE7DA2964E4"
Content-Language: fr
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This is a multi-part message in MIME format.
--------------4F56D0A3E9F3FFE7DA2964E4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

I just wanted to point a small thing:

On 2019-10-12 01:37, Song Liu wrote:
>
> David, you may consider adding "raid0.default_layout=?" to your kernel
> command line options.
> 
> Song

Currently there is a slight mis-match in the actual kernel module:
the warning message display "raid.default_layout=?" (missing zero)
instead of "raid0..." (how indeed it should be used).

Thank you very much.

PS: I'm a newbie I hope my message isn't improper.


--------------4F56D0A3E9F3FFE7DA2964E4
Content-Type: text/x-patch; charset=UTF-8;
 name="raiddefaultlayout_warningmessage.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="raiddefaultlayout_warningmessage.patch"

--- drivers/md/raid0.c.orig	2019-10-14 11:16:06.083342861 +0200
+++ drivers/md/raid0.c	2019-10-14 11:16:46.744319509 +0200
@@ -154,7 +154,7 @@
 	} else {
 		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_lay=
out setting\n",
 		       mdname(mddev));
-		pr_err("md/raid0: please set raid.default_layout to 1 or 2\n");
+		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
 		err =3D -ENOTSUPP;
 		goto abort;
 	}

--------------4F56D0A3E9F3FFE7DA2964E4--
