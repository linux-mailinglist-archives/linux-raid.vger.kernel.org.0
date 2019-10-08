Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E19CF338
	for <lists+linux-raid@lfdr.de>; Tue,  8 Oct 2019 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfJHHJZ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 8 Oct 2019 03:09:25 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40570 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHJZ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 8 Oct 2019 03:09:25 -0400
Received: by mail-wr1-f46.google.com with SMTP id h4so9275211wrv.7
        for <linux-raid@vger.kernel.org>; Tue, 08 Oct 2019 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pM231LI1EL7VKC1KPlHu3Bju2DPdpPhK18v4LsCNYYU=;
        b=NdOm318QDZ11iSBqHqbV/5IuummtDw+haE+Ut8OjsHIAUxPyodRprdXUGtildHEJOd
         4qoCuzdO2mAi8IfjyUlvWuA3PobOZxIwREEABK1ye0FDCl09NfNozstRKZPJcNFAF/fi
         7iQoJqpXRoi/157FP5t2c2eYXw4cUId/FiNhc5ooyszJmegGz+OyznXSc574+LnvKQdQ
         c4Ag/cw0RSwbwoMm7m5eQ2MCrqZ+gpLAxll9MvatEBFR6bcnsm/c+IdY47l6Vuf4hD5v
         DxSrJa/OxGQVFAPH+EoKg/fdVamPXsUKXS+Ty31ZUI/stwMZGgO2QGRT0S47bpAICoAX
         EE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pM231LI1EL7VKC1KPlHu3Bju2DPdpPhK18v4LsCNYYU=;
        b=WN+PV33JXd34PNjZlLAGnh+uoWkOML4WLn7xcb+UKuWx97cULJOoa0rHN08/YwWMYE
         rxZBSyTMh0Lhb2Y4S0XF0l5Ltqf57BIaTDedtM34wox554sNIpZM6tGK4wuHwFh1WpL7
         aPBugbZybsoB4rG93Aff77J3XYqAuI4k3MIoQJMEs5SHOtLoaOSzE4ZErKYLn2+YyjgW
         yQjhrHV6GIAjQPTYrN0HjbKvdbKl8He6ed+2D0Ur2syYqKtwDaP2RWksCnjzUjinNfu/
         EPlew0RU3aIdWItC+0yhfbTdlSxRNq4ca0WPcRSewvJw5zX8SsRfU3xZ1LNx5LUhi/8/
         Oq5A==
X-Gm-Message-State: APjAAAXeVg10uebf8B3jnjz/Hkj5YqmxP80S3lDEx8S1HpWiJzS8Oo+m
        9NrClx5NqKD0n7kD8M1m2fENyC/1wIwKQ9bqkQEmJwEq
X-Google-Smtp-Source: APXvYqz3e5LA48i+Lnp9yhboHiVOxFFPbnaiv4hhACIXMW8i90OHEUa/HwcVhWuMXy02e4a+giUFoX3TyIGOQrku0wM=
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr658337wrw.56.1570518563489;
 Tue, 08 Oct 2019 00:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Tue, 8 Oct 2019 00:09:12 -0700
Message-ID: <CAGRSmLtoqBrW40rVwazwC464ma_qjPxnJ3uobpfPRbCOagnnJQ@mail.gmail.com>
Subject: md/raid0: avoid RAID0 data corruption due to layout confusion. ?
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Cc:     NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

"So we add a module parameter to allow the old (0) or new (1) layout
to be specified, and refused to assemble an affected array if that
parameter is not set."

What does this mean for portable linux boot disks?  I don't recall
installing a module directly, but just running mdadm.  Where is this
parameter set?

Why couldn't it use an integrity logic check to determine which layout
version is used so it just works?

Thanks.
