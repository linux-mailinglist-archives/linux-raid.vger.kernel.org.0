Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08C18497
	for <lists+linux-raid@lfdr.de>; Thu,  9 May 2019 06:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfEIEkj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 May 2019 00:40:39 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:37348 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIEkj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 9 May 2019 00:40:39 -0400
Received: by mail-it1-f169.google.com with SMTP id l7so1309951ite.2
        for <linux-raid@vger.kernel.org>; Wed, 08 May 2019 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BP3RHhaZImlnSvpSLS5h/27vCzPopy+iRDDbBtMhSyA=;
        b=Inm2YBzw73ZEXmjQm94j6EX2YK8gFHySKWI2k7oyC/+7+8kluuKBQDFZSKF2hudU1L
         MJXcFdhlMPkWu4fGBDzqZoJ/wrsA7SPWzUI1jVa0gHMPBME/m4nQmwiVq1y+Z5uN+tW2
         NQFsjQdaSl8n3Esgvfw+oeRHAx5FPDBYYn72G6hingkJXFdNmsgyC1hAd6yxK9l2W3q9
         4/y/EivCxbhwEDVtIhWDdoOuQu8nF79dicEIQkBg8L1LTOfeAwnDufJayaS8Tnyh8Cbm
         TlagnuJo+rtyOhVezDiLaVhvQZQTc4YEWmaR0lGoFCEfiqabbRp8dPwJpsqVdpkNhM6a
         xl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BP3RHhaZImlnSvpSLS5h/27vCzPopy+iRDDbBtMhSyA=;
        b=SmJ/i7arLxpUVSPHU+Kfj9//4uhc6kCTsGXnIGEVPQKblDiiImkfeAPlTIM3k9NtH6
         HLjtFLgjqiNiYeNuxEF+2wDCoGJ4h+ay2WuB5IBlyYLLsyNUHkpwFReOFTz+Vf3X+ftN
         xMxOHLpgWzHZQ5ZmxXoFU4x6FhmJwIPILeWxHJj/gIMHpEhqROJI8/oUfZPa3LKzcqcD
         aSnrQK6fEUviVrn7kIFSFzR5057d/2l9R1Rbqs7UCEatWnTaW/IsCcst70ZymmjGTJnl
         o+t0UaSOaP5ZfUCf49yN5TOElSbTgWglfR83ASpg5nqk61VES2fRYPebq/mjQTEjjVsl
         qNbw==
X-Gm-Message-State: APjAAAVM6asinOdvG402A2VRc8SuqobJ6nVMglvAVHn5kulF0rod7++Y
        NyO46fYAUUhtk55qCWfxwePXxnOwvy6VmmiSmBPYQg==
X-Google-Smtp-Source: APXvYqxydZOEaYS+ylbfNjSjlwUWUuQ2ErBnZtiXyQR1YvjlK20wQ4URz8lsbTnFjeEAErDkHXK9DBcG2Md9eUZECns=
X-Received: by 2002:a24:354c:: with SMTP id k73mr1367769ita.175.1557376838224;
 Wed, 08 May 2019 21:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <1471924184.12974949.1557351707986.JavaMail.zimbra@karlsbakk.net>
From:   Mark Wagner <carnildo@gmail.com>
Date:   Wed, 8 May 2019 21:40:25 -0700
Message-ID: <CAA04aRTruz+Sh76zp+3SZAvSVM8XoA6LLiD6zkr2WnNzH9-_Ng@mail.gmail.com>
Subject: Re: ID 5 Reallocated Sectors Count
To:     Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, May 8, 2019 at 2:46 PM Roy Sigurd Karlsbakk <roy@karlsbakk.net> wro=
te:
>
> Hi
>
> I'm monitoring this box and it seems ID 5 Reallocated Sectors Count (from=
 SMART) is climbing frantically on one disk. It's a r6 so it shouldn't be m=
uch of an issue once the disk eventually fails, but does anyone out there k=
now how many reallocated sectors you can have on a drive? This is an older =
1TB ST31000524NS
>

That looks like a Seagate model number.  My experience with Seagate
drives from that era is that once you start seeing reallocated
sectors, it's time to replace the drive.  There seems to be something
with the firmware that greatly slows down drive detection as the
number of reallocated sectors increases, so the next time you
power-cycle the drive, it may get marked as failed.

--=20
Mark
