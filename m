Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93173C29F5
	for <lists+linux-raid@lfdr.de>; Tue,  1 Oct 2019 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfI3Ws3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 18:48:29 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53846 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3Ws3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 18:48:29 -0400
Received: by mail-wm1-f54.google.com with SMTP id i16so1136521wmd.3
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOLNyCZXFMCR4mFyKy8HpcRX7Q/yX9n1elzMZh3B/mU=;
        b=arQ166ARYQv83Hrr9Cf0Bpt/TL6nC4lxMeFm3pMMIOaXl03NYs6JFdMkVuNYKp25yk
         QsLfxgHEvxiu/zi15FyW7InihO6DJcIBQDhEFWl8Y9kUXLeIET9E9mf5To+CFTO7qy+b
         hkdNmK3wMRxhPJQ04BfqTudQgsBfddyHjpwiNmKT5A5Dtqnfz6P8/wN1YQHzHOx5xFZe
         +HJS19wV9VonkJkhgE2SBEJnlav+kg/4Gg+FVGQZhVEv8T/q0A64e+8XNHLL8zz/Tj9i
         y/LuFb33ohS+M1zQVq/1qeqN7KdrnY17kjlg0LUvYX+/YVxhGk7LIMq1XSVsYUA1xhUR
         DSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOLNyCZXFMCR4mFyKy8HpcRX7Q/yX9n1elzMZh3B/mU=;
        b=nNnzdPkNy+kTtxKuZ+2YXAJvw6aFu9wrxXaSew8jIcfQAmESC5v6CxTlMbiadIGDBP
         Di6xkv0lA+X4cDSn3lNjzMN6p9M1KM9/dKHap6skuCqT4v0nDsEbgyF/m39omPHpVqud
         Czoht/Z3nAHqLlc0Y9bWwmH39C8qSWDCDFsd1DYz2Rf+jXWyETS/L/T4flrhjp8BSmn3
         NBpDwu6L9cVX3XfW4EZp3F1Al1deFbru+E6s168rpslUW3o2d9P7VNPjwHUBA4xc7gD0
         zertXWy/Fm7vCmHI9aFRyhwpwlbe2vKNO79fMgu9s8krf74Lxqf2SpcWvQ6u8gzzMueA
         dbYw==
X-Gm-Message-State: APjAAAV6KTsEFQ+lZuqCQ3c6eFzC47DsUu2dQQmVov+aoTVHiqPSbThx
        kY5Wcc+QqGR2saun+znCibrEX8FNQV3NemlSkydSag==
X-Google-Smtp-Source: APXvYqxIoeRS5/ImQA+Rn4hXe3zkGRVfI9xhK/UPNd7UBHKcZ0zbD6KdMyn4SCQBFqW+hGdF3gMMv2c2qC2AHIHRY2w=
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr1078355wmh.112.1569883707198;
 Mon, 30 Sep 2019 15:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
 <20190930101443.GA2751@metamorpher.de> <CAGRSmLtpC_5HV9xfU+YHPEbCa+bMPTVCuGumK=4SmVm9pHODMg@mail.gmail.com>
In-Reply-To: <CAGRSmLtpC_5HV9xfU+YHPEbCa+bMPTVCuGumK=4SmVm9pHODMg@mail.gmail.com>
From:   "David F." <df7729@gmail.com>
Date:   Mon, 30 Sep 2019 15:48:16 -0700
Message-ID: <CAGRSmLuPquwR-VNbzhwHEdrVhDB2CWXD=4VQTx2AGdY7NyS1YQ@mail.gmail.com>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Do you know how /proc/partitions gets populated?

On Mon, Sep 30, 2019 at 9:07 AM David F. <df7729@gmail.com> wrote:
>
> One isn't defined, there is a mdadm.conf-default file but no actual
> file, so using the default.
>
> On Mon, Sep 30, 2019 at 3:14 AM Andreas Klauer
> <Andreas.Klauer@metamorpher.de> wrote:
> >
> > On Sun, Sep 29, 2019 at 03:54:41PM -0700, David F. wrote:
> > > So /proc/partitions can have floppy and optical drives on it.
> >
> > And people might rely on that so removing it is the wrong approach.
> >
> > What does your mdadm.conf look like, DEVICE devices?
> >
> > Regards
> > Andreas Klauer
