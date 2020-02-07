Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4221515618D
	for <lists+linux-raid@lfdr.de>; Sat,  8 Feb 2020 00:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGXWN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 18:22:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35126 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBGXWN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 18:22:13 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so3703368oie.2
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jR3u7IBEInS0gls262RsZ2zKiAq6IqfAdWwv2cx/GA=;
        b=WmM4SsvevHtGpgwZhHT4AaC04e5GKoTSErLTO/vY0ggIb6/kKyOk5uxWYZDRZZFNmT
         mIaTAgdyLh3P3z1LNEJ7vS2VpEfV78hHGt1ZOkEbz1VGgoiJox2SKim68AqwJ9743l04
         mA5v+ynv1GiWyfGdTBf2+0HXV3jneLR88poG+RZoLIHOqD3X0CgTGdu4V1FfZlEnhX+r
         UKuJXaw8qlJ24Sa9ysyjSZC57G0uD752lViVTrXTQ6wX/PBibejr/XkdKxQAqSm3RpvG
         WeZ34PSvsy1wcnkuTOyw2zMplL/vlQq+BXL50ka1d923urFY8FnEYjhRrmRQfEIVGXV1
         /U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jR3u7IBEInS0gls262RsZ2zKiAq6IqfAdWwv2cx/GA=;
        b=VJCYtpdzHgAMEo2dYfzQ63mvk1aVcFPZGWScGVBkBQcRQZil9y3Hnkkv9yw1HuoyrC
         dnN/KwZ9vz6NUxp1cdD2tXnz9cYDyDcU1M3YeUEUfL65vnvZLwyk7Iqe8uuWIIRM/YRA
         NJA3Yiw7Bv39AO9Zdtf8wbcndgIdV0KwPw/Chl50+44W2IOqOvppEtucAlNXBWduW9bP
         fJJC9EB/+AXboeypjvNgoKUQyeoX47E/w4vnpze8Nmj9SjFb3/+jHay/aY0R4y9vBM+7
         FFjuSEw3y3iwbfuFHSxLC4256hs20uUDz4wxLXcysCyRLT+1RaK1W1DSrPgVLV3P0WoM
         T58A==
X-Gm-Message-State: APjAAAUAkom90QcSDWLYnHy+BRfMtx8p/Bp6eSN89sgdJwmzby08Ujfh
        duJ4hy2wS8SUadI9kWYVT+YPn8q7ZAbd5U6qTb5Y4Fuv
X-Google-Smtp-Source: APXvYqwmeb2IyN94KMfEkWYb3Inb6P6d8uEkWdJA0wKePcv0183Q0oC7GRDdUnA+WYuaOcq7c34fKPhbfbD8ZxKyBeI=
X-Received: by 2002:aca:ed94:: with SMTP id l142mr3764155oih.58.1581117732289;
 Fri, 07 Feb 2020 15:22:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com>
In-Reply-To: <7af58e5b-7047-a3a8-f4b2-840ea6851dea@prgmr.com>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 17:21:36 -0600
Message-ID: <CAPpdf58BTV5duFoSfdC6_07+kqQy0zgfq4=PgErJHqVeikjgBA@mail.gmail.com>
Subject: Re: Question
To:     Sarah Newman <srn@prgmr.com>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Feb 7, 2020 at 4:50 PM Sarah Newman <srn@prgmr.com> wrote:
>
> On 2/7/20 7:49 AM, o1bigtenor wrote:
> > Greetings
> >
> > Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> > (11) system.
> > mdadm - v4.1 - 2018-10-01 is the version being used.
> >
> > Some weirdness is happening - - - vis a vis - - - I have one directory
> > (not small) that has disappeared. I last accessed said directory
> > (still have the pdf open which is how I could get this information)
> > 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> > section of the file in question.
>

Greetings


> I assume you've looked at lsof?

No I hadn't - - - - thanks for the tip.
only a few thousand line in a terminal - - - - - but nothing what I was
looking for.
>
> https://www.linux.com/news/bring-back-deleted-files-lsof/
>
> If it is a software problem, it just as likely, if not more likely, that it is a file system problem rather than a raid problem. You don't mention
> what file system. You're possibly also actually looking at data in the in-memory disk cache rather than what's actually stored on disk given there's
> been no reboot.

The array (raid-10) is on ext4.
>
> Is there anything suspicious in dmesg?

I hadn't looked at the messages files in /var/log so I went back to
date in question.
Didn't see anything there either.

What about doing this:

Made the array read only.
Copy the whole array using dd to a larger array on a different machine
(good overnight job).
Then run something like testdisk on the whole array.
The last would largely be a waste of time as what has
disappeared is one of about 40 upper level directories  and
it likely contained about 10 to 50 GB of files (dunno how many
levels of directories though - - - I use LOTS).

I'm looking for a reasonably solid method of trying to recover
this directory and all of its contents (about 8 years worth of
putting things into it so replicating it - - - - tough!).

Thanks for the assistance!
