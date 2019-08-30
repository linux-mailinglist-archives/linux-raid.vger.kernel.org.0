Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F3A35A5
	for <lists+linux-raid@lfdr.de>; Fri, 30 Aug 2019 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3L0M (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 30 Aug 2019 07:26:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfH3L0M (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 30 Aug 2019 07:26:12 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1i3f2g-0004Ia-Je
        for linux-raid@vger.kernel.org; Fri, 30 Aug 2019 11:26:10 +0000
Received: by mail-wm1-f72.google.com with SMTP id 19so3386012wmk.0
        for <linux-raid@vger.kernel.org>; Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONtyOFC+dZSA4vQOkPiU9xYclPOsHmknJnFItn//m5A=;
        b=bBhuQGtoZZ+prIJl7s48QC7I4CULuV/a+dlw2g44mA81AJf8sUCkFw0XWiZjNhBSta
         avvSwCwf3hOWerTjg4c0WFyZHq/XBMrSjmEFZJleOtKxQ+DDe6C+HG5DYkTOaufLb8eW
         EdGuO812MGBnKAZmfEpymVDg5/AnfPC/0yPpZC24Rp0m6uGuYzP0+qTIR8jVpyq9Ycsn
         5yv3jxkEoZcd0Zjd/Uzgct8Qzy1AoZJ9kdMnw3mxxB/X2B6oTPBww+WcbLePG7RuoL3T
         XdCZ7cKj5cyn1TFdw+JyicCLmqxRFfaimFNolttqqvWCAhMHuWInPAXTlIiOrK92mtb1
         OJYQ==
X-Gm-Message-State: APjAAAWFPBkryCiuLKoAGfIddzxNGWzSqZ4JKi0m0CvTmBuCzI1DrUnx
        nDEUokqLupSTQbJeLdQjGz19VnRC3RJO5CQ5T8G1DiY7t7yr7+BdJl07I8Fi7PXpn6nM+ICs6Wk
        MuXI16PcBcRq97MwRQdBSEdr0845PTa6EfclLlckIYSZlHtpwZ7V0kJA=
X-Received: by 2002:adf:ed44:: with SMTP id u4mr8257335wro.185.1567164370409;
        Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzD8gpVqNLfcWj5d2bwlzCAH3DlE5KPUT3AYaexNUWZirMrkm8yqm7IWovyEtVJINJJASgUfjsaN0RaC4cQnpg=
X-Received: by 2002:adf:ed44:: with SMTP id u4mr8257319wro.185.1567164370271;
 Fri, 30 Aug 2019 04:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com> <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
 <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com> <5D68FEBC.9060709@youngman.org.uk>
In-Reply-To: <5D68FEBC.9060709@youngman.org.uk>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Fri, 30 Aug 2019 08:25:34 -0300
Message-ID: <CAHD1Q_ypdBKhYRVLrg_kf4L8LdXk8rgiiSQjtmoC=jyRv5M5jQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks a lot for all the suggestions Song, Neil and Wol - I'll
implement them and resubmit
(hopefully) Monday.

Cheers,


Guilherme
